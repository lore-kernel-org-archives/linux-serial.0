From: Gimcuan Hui <gimcuan@gmail.com>
Subject: [PATCH 0/5] TTY/JSM coding style fixes
Date: Sun,  5 Nov 2017 05:06:17 +0000
Message-ID: <cover.1509853735.git.gimcuan@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

This patch set fixes several warnings and errors reported
by checkpatch.pl.

Gimcuan Hui (5):
  tty: serial: jsm: change the type of local variable
  tty: serial: jsm: add blank line after declarations
  tty: serial: jsm: delete space between function name and '('
  tty: serial: jsm: fix coding style
  tty: serial: jsm: add space before the open parenthesis '('

 drivers/tty/serial/jsm/jsm_tty.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

-- 
2.11.0
