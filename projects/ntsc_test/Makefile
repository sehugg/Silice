
.DEFAULT: ntsc_test.ice
ifdef tool
		silice-make.py -s ntsc_test.ice -b $@ -p ntsc -o BUILD_$(subst :,_,$@) -t $(tool)
else
		silice-make.py -s ntsc_test.ice -b $@ -p ntsc -o BUILD_$(subst :,_,$@)
endif

icarus:
		silice-make.py -s ntsc_test.ice -b $@ -p ntsc,top_only -o BUILD_$(subst :,_,$@)

clean:
	rm -rf BUILD_*
