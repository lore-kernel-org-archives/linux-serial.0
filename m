From: "Matwey V. Kornilov" <matwey@sai.msu.ru>
Subject: [PATCH v6 0/3] tty: Introduce software RS485 direction control support
Date: Mon, 21 Dec 2015 21:26:16 +0300
Message-ID: <1450722379-13438-1-git-send-email-matwey@sai.msu.ru>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.com, peter@hurleysoftware.com, andy.shevchenko@gmail.com, gnomes@lxorguk.ukuu.org.uk
Cc: "Matwey V. Kornilov" <matwey@sai.msu.ru>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Changes from v5:
 - rs485_emul variable has been renamed to em485 to follow function names convention
Changes from v4:
 - Add commit message to 1/3
Changes from v3:
 - Completely redesigned.
Changes from v2:
 - Introduced SER_RS485_SOFTWARE to show that software implementation is being used
 - serial8250_rs485_config is located as required
 - Timers are used to implement delay_before and delay_after timeouts

Signed-off-by: Matwey V. Kornilov <matwey@sai.msu.ru>
