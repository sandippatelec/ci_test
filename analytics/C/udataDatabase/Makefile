#!/bin/sh
TARGET := udataDatabase
RM := rm -rf
MD := mkdir -p
MV := mv
BIN := bin

CXX		:= gcc

CXXFLAGS := -g 
OUTPUT := output
SRC_PATH := ./src ./../lib
SRC := $(foreach dir,$(SRC_PATH),$(wildcard $(dir)/*.c))
INCLUDES += -I ../include/ 

OBJ_FILES := $(patsubst $(SRC_PATH)/%.c,%.o,$(SRC:.c=.o))

all: $(TARGET)

$(TARGET): $(OBJ_FILES)
	$(MD) ./$(OUTPUT)
	$(MD) ./../$(BIN)
	$(MV) *.o ./$(OUTPUT)
	$(CXX) -I. ./$(OUTPUT)/*.o -o $(TARGET) $(CXXFLAGS)
	$(MV) $(TARGET) ./../$(BIN)
%.o: %.c
	$(CXX) $(INCLUDES) $(CXXFLAGS) -c $<

.PHONEY:clean

clean :
	rm -rf output $(TARGET)
