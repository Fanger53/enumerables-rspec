# rubocop:disable Metrics/ModuleLength, Metrics/MethodLength, Metrics/PerceivedComplexity, Metrics/CyclomaticComplexity, Style/DoubleNegation, Metrics/BlockNesting
# module
module Enumerable
  # Each methods
  def my_each
    return to_enum unless block_given?

    index = 0
    while index < size
      yield to_a[index]
      index += 1
    end
    self
  end

  # Each index
  def my_each_with_index
    return to_enum unless block_given?

    index = 0
    while index < to_a.length
      yield(Array(self)[index], index)
      index += 1
    end
    self
  end

  # my_select Method
  def my_select
    return to_enum unless block_given?

    new_arr = []
    my_each do |n|
      new_arr << n if yield(n)
    end
    new_arr
  end

  # my_all Method
  def my_all?(argument = nil)
    index = 0
    my = to_a
    while index < my.length
      if block_given?
        return false if yield(my[index]) == false
      else
        if argument.nil? # when there is no argument
          return false if my[index].nil? || my[index] == false
        elsif argument.class == Regexp # when there is an argument
          return false if my[index].match?(argument) != true
        elsif argument.class == Class
          return false if my[index].is_a?(argument) != true
        else # when the argument is no regexp ni class
          return false if my[index] != argument
        end
      end
      index += 1
    end
    true
  end

  # my_any? Method

  def my_any?(cond = nil)
    classflag = false
    if !cond.nil?
      if cond.is_a?(Class)
        my_each do |e|
          if e.is_a?(cond)
            classflag = true
            break
          end
        end
      elsif cond == Numeric
        my_each do |e|
          if e.is_a?(Numeric)
            classflag = true
            break
          end
        end
      elsif cond != Class and cond.is_a?(Regexp)
        my_each do |e|
          if e.is_a?(String)
            if e.match?(cond)
              classflag = true
              break
            end
          end
        end
      elsif !cond.is_a?(Numeric) and !!cond == cond
        my_each do |e|
          if e == cond
            classflag = true
            break
          end
        end
      elsif cond.is_a?(Numeric) || cond.is_a?(String)
        my_each do |e|
          if cond == e
            classflag = true
            break
          end
        end
      end
    elsif block_given?
      my_each do |e|
        if yield(e)
          classflag = true
          break
        end
      end
    elsif cond.nil? and !block_given?
      my_each do |m|
        return true if m == true
      end
      false
    else
      false
    end
    classflag
  end

  # my_none Simplest Approach

  def my_none?(arg = nil, &block)
    !my_any?(arg, &block)
  end

  # my_count Method
  def my_count(cond = nil)
    counter = 0
    if block_given?
      my_each do |f|
        counter += 1 if yield f
      end
      counter
    elsif cond.nil?
      to_a.length
    elsif !cond.nil?
      my_each do |e|
        counter += 1 if cond == e
      end
      counter
    end
  end

  # my_map method
  def my_map(pro = nil)
    new_array = []
    if pro.is_a?(Proc)
      my_each do |e|
        new_array.push(pro.call(e))
      end
      new_array
    elsif !block_given?
      new_array = to_enum
      new_array
    elsif block_given?
      my_each do |e|
        new_array.push(yield e)
      end
      new_array
    else
      new_array = self
    end
    new_array
  end

  # my_inject Method
  def my_inject(*args)
    array = to_a
    if !block_given? && args.empty?
      yield
    else
      if args.length == 1 && args[0].class == Symbol
        symb = args[0]
        res = nil
      elsif args.length == 1
        symb = nil
        res = args[0]
      elsif args.length == 2
        symb = args[1]
        res = args[0]
      else
        symb = nil
        res = nil
      end
      if res.nil?
        total = array[0]
        check = 0
      else
        total = res
        check = 1
      end
      lambda_ = symb.nil? ? ->(_, bar) { yield(total, bar) } : ->(_, bar) { total.send(symb, bar) }
      array.my_each do |i|
        total = lambda_.call(total, i) if check == 1
        check = 1
      end
      total
    end
  end

  # my_map_proc Method
  def my_map_proc(pro)
    new_array = []
    if pro.is_a?(Proc)
      my_each do |e|
        new_array.push(pro.call(e))
      end
      new_array
    else
      new_array = self
    end
    new_array
  end

  # my_multiply_els Method
  def my_multiply_els(arr)
    arr.my_inject { |sum, n| sum * n }
  end
end

# rubocop:enable Metrics/ModuleLength, Metrics/MethodLength, Metrics/PerceivedComplexity, Metrics/CyclomaticComplexity, Style/DoubleNegation, Metrics/BlockNesting
