From: =?UTF-8?q?Frederik=20V=C3=B6lkel?= <frederik.voelkel@fau.de>
Subject: [PATCH 0/9] Fix checkpatch errors
Date: Fri, 11 Dec 2015 11:36:00 +0100
Message-ID: <1449830170-15096-1-git-send-email-frederik.voelkel@fau.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc: jslaby@suse.com, gregkh@linuxfoundation.org, linux-kernel@i4.cs.fau.de, =?UTF-8?q?Frederik=20V=C3=B6lkel?= <frederik.voelkel@fau.de>
List-Id: linux-serial@vger.kernel.org

This patch series fixes all checkpatch error in 68328serial.c except
5 trailing whitespace errors we are unsure how to fix.
Checkpatch warnings are unfixed. Maybe we send an patch series witch fi=
x
these warnings later on.

=46rederik V=C3=B6lkel (9):
  drivers: tty: 68328serial.c: Add missing spaces(checkpatch)
  drivers: tty: 68328serial.c: remove unnecessary spaces(checkpatch)
  drivers: tty: 68328serial.c: Do not initialize statics to 0
  drivers: tty: 68328serial.c: Fix "foo * bar" should be "foo *bar"
  drivers: tty: 68328serial.c: Remove parentheses after return
  drivers: tty: 68328serial.c: Use tabs for indentation
  drivers: tty: 68328serial.c: remove trailing whitespaces
  drivers: tty: 68328serial.c: Use use same indentation for switch/case
  drivers: tty: 68328serial.c: Move trailing statements to next line

 drivers/tty/serial/68328serial.c | 337 ++++++++++++++++++++-----------=
--------
 1 file changed, 171 insertions(+), 166 deletions(-)

--=20
1.9.1
