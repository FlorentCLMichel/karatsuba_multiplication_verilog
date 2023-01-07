clean: 
	rm -rf obj_dir
	rm -rf src/__pycache__

test:
	verilator -Wall --cc --exe --build tests/${name}.cpp tests/${name}.v --top-module ${name}
	obj_dir/V${name}

LIST_TESTS = addition subtraction mul_2

.PHONY: all_tests
all_tests:
	@echo ""
	@$(foreach file,$(LIST_TESTS), \
		echo "COMPILING ${file}"; \
		verilator -j 0 -Wall --cc --build --exe tests/${file}.cpp tests/${file}.v ${flags} 1> /dev/null ; \
	)
	@echo "\nRUN THE TESTS\n________________________________________________________________________________\n"
	@$(foreach file,$(LIST_TESTS), \
		./obj_dir/V${file} ; \
	)
