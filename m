From: "Matwey V. Kornilov" <matwey@sai.msu.ru>
Subject: [PATCH v8 0/3] tty: Introduce software RS485 direction control support
Date: Mon,  1 Feb 2016 21:09:19 +0300
Message-ID: <1454350162-1840-1-git-send-email-matwey@sai.msu.ru>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.com, peter@hurleysoftware.com, andy.shevchenko@gmail.com, gnomes@lxorguk.ukuu.org.uk
Cc: "Matwey V. Kornilov" <matwey@sai.msu.ru>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Changes from v7:
 - rework comments to follow guidelines
 - minor style changes
Changes from v6:
 - minor style changes
 - timers are not IRQSAFE now
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
