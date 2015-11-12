From: "Matwey V. Kornilov" <matwey@sai.msu.ru>
Subject: [PATCH v3 0/5] tty: Introduce software RS485 direction control support
Date: Thu, 12 Nov 2015 17:33:51 +0300
Message-ID: <1447338836-8785-1-git-send-email-matwey@sai.msu.ru>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.com, peter@hurleysoftware.com
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Changes from v2:
 - Introduced SER_RS485_SOFTWARE to show that software implementation is being used
 - serial8250_rs485_config is located as required
 - Timers are used to implement delay_before and delay_after timeouts
