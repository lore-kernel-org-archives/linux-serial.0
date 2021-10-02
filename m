Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDD82C433F5
	for <linux-serial@archiver.kernel.org>; Sat,  2 Oct 2021 13:09:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C648861AF7
	for <linux-serial@archiver.kernel.org>; Sat,  2 Oct 2021 13:09:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232949AbhJBNL1 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 2 Oct 2021 09:11:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:56270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232821AbhJBNL1 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Sat, 2 Oct 2021 09:11:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4E0E061AE0;
        Sat,  2 Oct 2021 13:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633180181;
        bh=6yVYyz2ScywFmKSZH3jBX2CrwSLdM6zkZln8XU6qjxI=;
        h=From:To:Cc:Subject:Date:From;
        b=bDwK/yEO4sqP184OX4wGd8mV+lfK96PiNgPa4HbOupXS9hl0WaZTvSmI3HS4QxyJX
         pKdBDA5+dh5dRAWW3FlF7UDd7AKjG//bWfyHc9Ccx9JuwylwLCXfom3l/tLvuI2ngM
         myfCrTJEKMvvcAk3lAYNM+CnWN6sSkqV32SInBVmAMmWPON4b0vxWk0TvZbE2u4ont
         eXanV9vLuPKR28gbpo9yDhHc5nCvHL4qb5mjWfa/3JaNx3iuh1d4dSSLMCBVxeS6sS
         P+l0DPY/KwM6J/EpIzIJtnCHEaNrM7qVMAoo7WwoBozj+Vrnst+kwgZGB4+9l2e93g
         E0UeHY4bgO1lQ==
Received: by pali.im (Postfix)
        id 31AC71087; Sat,  2 Oct 2021 15:09:39 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] serial: core: Fix initializing and restoring termios speed
Date:   Sat,  2 Oct 2021 15:09:00 +0200
Message-Id: <20211002130900.9518-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Since commit edc6afc54968 ("tty: switch to ktermios and new framework")
termios speed is no longer stored only in c_cflag member but also in new
additional c_ispeed and c_ospeed members. If BOTHER flag is set in c_cflag
then termios speed is stored only in these new members.

Therefore to correctly restore termios speed it is required to store also
ispeed and ospeed members, not only cflag member.

In case only cflag member with BOTHER flag is restored then functions
tty_termios_baud_rate() and tty_termios_input_baud_rate() returns baudrate
stored in c_ospeed / c_ispeed member, which is zero as it was not restored
too. If reported baudrate is invalid (e.g. zero) then serial core functions
report fallback baudrate value 9600. So it means that in this case original
baudrate is lost and kernel changes it to value 9600.

Simple reproducer of this issue is to boot kernel with following command
line argument: "console=ttyXXX,86400" (where ttyXXX is the device name).
For speed 86400 there is no Bnnn constant and therefore kernel has to
represent this speed via BOTHER c_cflag. Which means that speed is stored
only in c_ospeed and c_ispeed members, not in c_cflag anymore.

If bootloader correctly configures serial device to speed 86400 then kernel
prints boot log to early console at speed speed 86400 without any issue.
But after kernel starts initializing real console device ttyXXX then speed
is changed to fallback value 9600 because information about speed was lost.

This patch fixes above issue by storing and restoring also ispeed and
ospeed members, which are required for BOTHER flag.

Signed-off-by: Pali Rohár <pali@kernel.org>
Fixes: edc6afc54968 ("tty: switch to ktermios and new framework")
Cc: stable@vger.kernel.org
---
 drivers/tty/serial/serial_core.c | 16 ++++++++++++++--
 include/linux/console.h          |  2 ++
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 18266ea830d2..3f48b540ff1e 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -222,7 +222,11 @@ static int uart_port_startup(struct tty_struct *tty, struct uart_state *state,
 	if (retval == 0) {
 		if (uart_console(uport) && uport->cons->cflag) {
 			tty->termios.c_cflag = uport->cons->cflag;
+			tty->termios.c_ispeed = uport->cons->ispeed;
+			tty->termios.c_ospeed = uport->cons->ospeed;
 			uport->cons->cflag = 0;
+			uport->cons->ispeed = 0;
+			uport->cons->ospeed = 0;
 		}
 		/*
 		 * Initialise the hardware port settings.
@@ -290,8 +294,11 @@ static void uart_shutdown(struct tty_struct *tty, struct uart_state *state)
 		/*
 		 * Turn off DTR and RTS early.
 		 */
-		if (uport && uart_console(uport) && tty)
+		if (uport && uart_console(uport) && tty) {
 			uport->cons->cflag = tty->termios.c_cflag;
+			uport->cons->ispeed = tty->termios.c_ispeed;
+			uport->cons->ospeed = tty->termios.c_ospeed;
+		}
 
 		if (!tty || C_HUPCL(tty))
 			uart_port_dtr_rts(uport, 0);
@@ -2100,8 +2107,11 @@ uart_set_options(struct uart_port *port, struct console *co,
 	 * Allow the setting of the UART parameters with a NULL console
 	 * too:
 	 */
-	if (co)
+	if (co) {
 		co->cflag = termios.c_cflag;
+		co->ispeed = termios.c_ispeed;
+		co->ospeed = termios.c_ospeed;
+	}
 
 	return 0;
 }
@@ -2235,6 +2245,8 @@ int uart_resume_port(struct uart_driver *drv, struct uart_port *uport)
 		 */
 		memset(&termios, 0, sizeof(struct ktermios));
 		termios.c_cflag = uport->cons->cflag;
+		termios.c_ispeed = uport->cons->ispeed;
+		termios.c_ospeed = uport->cons->ospeed;
 
 		/*
 		 * If that's unset, use the tty termios setting.
diff --git a/include/linux/console.h b/include/linux/console.h
index 20874db50bc8..a97f277cfdfa 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -149,6 +149,8 @@ struct console {
 	short	flags;
 	short	index;
 	int	cflag;
+	uint	ispeed;
+	uint	ospeed;
 	void	*data;
 	struct	 console *next;
 };
-- 
2.20.1

