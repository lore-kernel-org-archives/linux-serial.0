From: LABBE Corentin <clabbe.montjoie@gmail.com>
Subject: [PATCH v2 0/1] serial: imx: fix a possible NULL dereference
Date: Tue, 24 Nov 2015 15:36:56 +0100
Message-ID: <1448375817-16189-1-git-send-email-clabbe.montjoie@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.com
Cc: LABBE Corentin <clabbe.montjoie@gmail.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hello

Changes since v1
- Use of_device_get_match_data as suggested by Uwe Kleine-Konig

LABBE Corentin (2):
  serial: imx: fix a possible NULL dereference
  serial: imx: constify imx_uart_data structures

 drivers/tty/serial/imx.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

-- 
2.4.10
