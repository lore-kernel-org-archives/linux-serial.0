From: Valentin Rothberg <valentinrothberg@gmail.com>
Subject: [PATCH 0/4] drivers/tty/serial: fix Kconfig issues in crisv10.c
Date: Sat, 11 Apr 2015 15:55:59 +0200
Message-ID: <1428760563-13413-1-git-send-email-valentinrothberg@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: starvik@axis.com, jesper.nilsson@axis.com, gregkh@linuxfoundation.org, jslaby@suse.cz, linux-cris-kernel@axis.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, pebolle@tiscali.nl
Cc: Valentin Rothberg <valentinrothberg@gmail.com>
List-Id: linux-serial@vger.kernel.org

This small patch set addresses various Kconfig related issues in
crisv10.c such as fixing naming conventions and removing dead code.  The
dead code did not compile for years so I assume that it can be removed
safely.

Please note that I am not able to test compile these changes.
I detected all issues with scripts/checkkconfigsymbols.py

Valentin Rothberg (4):
  drivers/tty/serial/crisv10.c: remove dead #ifdef block
  drivers/tty/serial/crisv10.c: remove dead #ifdef blocks
  drivers/tty/serial/crisv10.c: remove dead #ifdef blocks
  drivers/tty/serial/crisv10.c: rename CPP identifier
    CONFIG_ETRAX_SERX_DTR_RI_DSR_CD_MIXED

 drivers/tty/serial/crisv10.c | 86 +++-----------------------------------------
 1 file changed, 4 insertions(+), 82 deletions(-)

-- 
2.1.0
