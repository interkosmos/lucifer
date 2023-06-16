C     ******************************************************************
C
C     TEST PROGRAM FOR LUCIFER CIPHER.
C
C     ******************************************************************
      PROGRAM MAIN
      EXTERNAL TEST1, TEST2, TEST3, TEST4

      CALL SRAND(TIME())

      CALL TEST1()
      CALL TEST2()
      CALL TEST3()
      CALL TEST4()
      END
C     ******************************************************************
      SUBROUTINE TEST1()
      EXTERNAL CIPHER
      CHARACTER*32 KEY, MSG

      PRINT *, '>>> TEST 1'

      KEY = '0123456789ABCDEFFEDCBA9876543210'
      MSG = 'AAAAAAAAAAAAAAAABBBBBBBBBBBBBBBB'

      PRINT *, 'KEY: ', KEY
      PRINT *, 'MSG: ', MSG

      CALL CIPHER(0, KEY, MSG)
      PRINT *, 'ENCRYPTED: ', MSG
      PRINT *, 'EXPECTED:  ', '7C790EFDE03679E4BF28FE2D199E41A0'

      CALL CIPHER(1, KEY, MSG)
      PRINT *, 'DECRYPTED: ', MSG
      END
C     ******************************************************************
      SUBROUTINE TEST2()
      EXTERNAL CIPHER
      CHARACTER*32 KEY, MSG
      INTEGER I

      PRINT *, '>>> TEST 2'

      WRITE (KEY, 100) (INT(RAND() * 16), I = 1, 32)

      MSG = 'AAAAAAAAAAAAAAAABBBBBBBBBBBBBBBB'

      PRINT *, 'KEY: ', KEY
      PRINT *, 'MSG: ', MSG
      CALL CIPHER(0, KEY, MSG)
      PRINT *, 'ENCRYPTED: ', MSG

      CALL CIPHER(1, KEY, MSG)
      PRINT *, 'DECRYPTED: ', MSG

  100 FORMAT (32Z1.1)
      END
C     ******************************************************************
      SUBROUTINE TEST3()
      EXTERNAL CIPHER
      CHARACTER*32 KEY, MSG
      INTEGER I, J
      REAL T1, T2

      PRINT *, '>>> TEST 3'
      MSG = 'AAAAAAAAAAAAAAAABBBBBBBBBBBBBBBB'

      CALL CPU_TIME(T1)

      DO 10 J = 1, 1000
      WRITE (KEY, 100) (INT(RAND() * 16), I = 1, 32)
      CALL CIPHER(0, KEY, MSG)
      CALL CIPHER(1, KEY, MSG)
   10 CONTINUE

      CALL CPU_TIME(T2)
      PRINT 200, T2 - T1

  100 FORMAT (32Z1.1)
  200 FORMAT (' 1000 RUNS IN ',F12.8,' SECONDS')
      END
C     ******************************************************************
      SUBROUTINE TEST4()
      EXTERNAL A2HEX, CIPHER, HEX2A
      CHARACTER*16 RAWKEY, RAWMSG
      CHARACTER*32 KEY, MSG

      PRINT *, '>>> TEST 4'

      RAWKEY = 'SUPERSECRET'
      RAWMSG = 'ATTACK AT DAWN'

      CALL A2HEX(RAWKEY, KEY)
      CALL A2HEX(RAWMSG, MSG)

      PRINT *, 'KEY: ', KEY
      PRINT *, 'MSG: ', MSG

      CALL CIPHER(0, KEY, MSG)

      PRINT *, 'ENCRYPTED: ', MSG
      PRINT *, 'ASCII:     ', RAWMSG

      CALL CIPHER(1, KEY, MSG)
      CALL HEX2A(MSG, RAWMSG)

      PRINT *, 'DECRYPTED: ', MSG
      PRINT *, 'ASCII:     ', RAWMSG
      END
