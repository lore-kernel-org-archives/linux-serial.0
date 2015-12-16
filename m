From: =?UTF-8?q?Frederik=20V=C3=B6lkel?= <frederik.voelkel@fau.de>
Subject: [PATCH v2 0/4] Fix checkpatch errors
Date: Wed, 16 Dec 2015 16:16:57 +0100
Message-ID: <1450279021-17154-1-git-send-email-frederik.voelkel@fau.de>
References: <1449830170-15096-1-git-send-email-frederik.voelkel@fau.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1449830170-15096-1-git-send-email-frederik.voelkel@fau.de>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.com
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, lukas.braun@fau.de, linux-kernel@i4.cs.fau.de, =?UTF-8?q?Frederik=20V=C3=B6lkel?= <frederik.voelkel@fau.de>
List-Id: linux-serial@vger.kernel.org

This is the rest of the previous patchseries witch fixes now all of the
whitespace errors and fixes the wrong indentation.

=46rederik V=C3=B6lkel (4):
  drivers: tty: 68328serial.c: Use tabs for indentation
  drivers: tty: 68328serial.c: remove trailing whitespaces
  drivers: tty: 68328serial.c: Use use same indentation for switch/case
  drivers: tty: 68328serial.c: Move trailing statements to next line

 drivers/tty/serial/68328serial.c | 255 ++++++++++++++++++++-----------=
--------
 1 file changed, 130 insertions(+), 125 deletions(-)

--=20
1.9.1
