Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4704C63708
	for <linux-serial@archiver.kernel.org>; Wed,  7 Dec 2022 22:05:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbiLGWFf (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 7 Dec 2022 17:05:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbiLGWFP (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 7 Dec 2022 17:05:15 -0500
Received: from mail.someserver.de (mail2.someserver.de [31.15.66.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E67E085667
        for <linux-serial@vger.kernel.org>; Wed,  7 Dec 2022 14:04:15 -0800 (PST)
Received: from localhost (unknown [213.55.243.226])
        by mail.someserver.de (Postfix) with ESMTPSA id CAAC9801CD;
        Wed,  7 Dec 2022 22:56:27 +0100 (CET)
From:   Christina Quast <contact@christina-quast.de>
To:     linux-serial@vger.kernel.org
Cc:     Christina Quast <contact@christina-quast.de>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Daniel Beer <daniel.beer@igorinstitute.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH tty-next 3/3] hid-ft260: Change u8 to __u8 for hw facing structs
Date:   Wed,  7 Dec 2022 22:55:40 +0100
Message-Id: <20221207215540.114920-4-contact@christina-quast.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221207215540.114920-1-contact@christina-quast.de>
References: <20221207215540.114920-1-contact@christina-quast.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Signed-off-by: Christina Quast <contact@christina-quast.de>
Cc: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Cc: Daniel Beer <daniel.beer@igorinstitute.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hid/hid-ft260.c | 92 ++++++++++++++++++++---------------------
 1 file changed, 46 insertions(+), 46 deletions(-)

diff --git a/drivers/hid/hid-ft260.c b/drivers/hid/hid-ft260.c
index 59b6cab13946..8979f85a1ac3 100644
--- a/drivers/hid/hid-ft260.c
+++ b/drivers/hid/hid-ft260.c
@@ -129,93 +129,93 @@ enum {
 /* Feature In reports */
 
 struct ft260_get_chip_version_report {
-	u8 report;		/* FT260_CHIP_VERSION */
-	u8 chip_code[4];	/* FTDI chip identification code */
-	u8 reserved[8];
+	__u8 report;		/* FT260_CHIP_VERSION */
+	__u8 chip_code[4];	/* FTDI chip identification code */
+	__u8 reserved[8];
 } __packed;
 
 struct ft260_get_system_status_report {
-	u8 report;		/* FT260_SYSTEM_SETTINGS */
-	u8 chip_mode;		/* DCNF0 and DCNF1 status, bits 0-1 */
-	u8 clock_ctl;		/* 0 - 12MHz, 1 - 24MHz, 2 - 48MHz */
-	u8 suspend_status;	/* 0 - not suspended, 1 - suspended */
-	u8 pwren_status;	/* 0 - FT260 is not ready, 1 - ready */
-	u8 i2c_enable;		/* 0 - disabled, 1 - enabled */
-	u8 uart_mode;		/* 0 - OFF; 1 - RTS_CTS, 2 - DTR_DSR, */
+	__u8 report;		/* FT260_SYSTEM_SETTINGS */
+	__u8 chip_mode;		/* DCNF0 and DCNF1 status, bits 0-1 */
+	__u8 clock_ctl;		/* 0 - 12MHz, 1 - 24MHz, 2 - 48MHz */
+	__u8 suspend_status;	/* 0 - not suspended, 1 - suspended */
+	__u8 pwren_status;	/* 0 - FT260 is not ready, 1 - ready */
+	__u8 i2c_enable;		/* 0 - disabled, 1 - enabled */
+	__u8 uart_mode;		/* 0 - OFF; 1 - RTS_CTS, 2 - DTR_DSR, */
 				/* 3 - XON_XOFF, 4 - No flow control */
-	u8 hid_over_i2c_en;	/* 0 - disabled, 1 - enabled */
-	u8 gpio2_function;	/* 0 - GPIO,  1 - SUSPOUT, */
+	__u8 hid_over_i2c_en;	/* 0 - disabled, 1 - enabled */
+	__u8 gpio2_function;	/* 0 - GPIO,  1 - SUSPOUT, */
 				/* 2 - PWREN, 4 - TX_LED */
-	u8 gpioA_function;	/* 0 - GPIO, 3 - TX_ACTIVE, 4 - TX_LED */
-	u8 gpioG_function;	/* 0 - GPIO, 2 - PWREN, */
+	__u8 gpioA_function;	/* 0 - GPIO, 3 - TX_ACTIVE, 4 - TX_LED */
+	__u8 gpioG_function;	/* 0 - GPIO, 2 - PWREN, */
 				/* 5 - RX_LED, 6 - BCD_DET */
-	u8 suspend_out_pol;	/* 0 - active-high, 1 - active-low */
-	u8 enable_wakeup_int;	/* 0 - disabled, 1 - enabled */
-	u8 intr_cond;		/* Interrupt trigger conditions */
-	u8 power_saving_en;	/* 0 - disabled, 1 - enabled */
-	u8 reserved[10];
+	__u8 suspend_out_pol;	/* 0 - active-high, 1 - active-low */
+	__u8 enable_wakeup_int;	/* 0 - disabled, 1 - enabled */
+	__u8 intr_cond;		/* Interrupt trigger conditions */
+	__u8 power_saving_en;	/* 0 - disabled, 1 - enabled */
+	__u8 reserved[10];
 } __packed;
 
 struct ft260_get_i2c_status_report {
-	u8 report;		/* FT260_I2C_STATUS */
-	u8 bus_status;		/* I2C bus status */
+	__u8 report;		/* FT260_I2C_STATUS */
+	__u8 bus_status;		/* I2C bus status */
 	__le16 clock;		/* I2C bus clock in range 60-3400 KHz */
-	u8 reserved;
+	__u8 reserved;
 } __packed;
 
 /* Feature Out reports */
 
 struct ft260_set_system_clock_report {
-	u8 report;		/* FT260_SYSTEM_SETTINGS */
-	u8 request;		/* FT260_SET_CLOCK */
-	u8 clock_ctl;		/* 0 - 12MHz, 1 - 24MHz, 2 - 48MHz */
+	__u8 report;		/* FT260_SYSTEM_SETTINGS */
+	__u8 request;		/* FT260_SET_CLOCK */
+	__u8 clock_ctl;		/* 0 - 12MHz, 1 - 24MHz, 2 - 48MHz */
 } __packed;
 
 struct ft260_set_i2c_mode_report {
-	u8 report;		/* FT260_SYSTEM_SETTINGS */
-	u8 request;		/* FT260_SET_I2C_MODE */
-	u8 i2c_enable;		/* 0 - disabled, 1 - enabled */
+	__u8 report;		/* FT260_SYSTEM_SETTINGS */
+	__u8 request;		/* FT260_SET_I2C_MODE */
+	__u8 i2c_enable;		/* 0 - disabled, 1 - enabled */
 } __packed;
 
 struct ft260_set_uart_mode_report {
-	u8 report;		/* FT260_SYSTEM_SETTINGS */
-	u8 request;		/* FT260_SET_UART_MODE */
-	u8 uart_mode;		/* 0 - OFF; 1 - RTS_CTS, 2 - DTR_DSR, */
+	__u8 report;		/* FT260_SYSTEM_SETTINGS */
+	__u8 request;		/* FT260_SET_UART_MODE */
+	__u8 uart_mode;		/* 0 - OFF; 1 - RTS_CTS, 2 - DTR_DSR, */
 				/* 3 - XON_XOFF, 4 - No flow control */
 } __packed;
 
 struct ft260_set_i2c_reset_report {
-	u8 report;		/* FT260_SYSTEM_SETTINGS */
-	u8 request;		/* FT260_SET_I2C_RESET */
+	__u8 report;		/* FT260_SYSTEM_SETTINGS */
+	__u8 request;		/* FT260_SET_I2C_RESET */
 } __packed;
 
 struct ft260_set_i2c_speed_report {
-	u8 report;		/* FT260_SYSTEM_SETTINGS */
-	u8 request;		/* FT260_SET_I2C_CLOCK_SPEED */
+	__u8 report;		/* FT260_SYSTEM_SETTINGS */
+	__u8 request;		/* FT260_SET_I2C_CLOCK_SPEED */
 	__le16 clock;		/* I2C bus clock in range 60-3400 KHz */
 } __packed;
 
 /* Data transfer reports */
 
 struct ft260_i2c_write_request_report {
-	u8 report;		/* FT260_I2C_REPORT */
-	u8 address;		/* 7-bit I2C address */
-	u8 flag;		/* I2C transaction condition */
-	u8 length;		/* data payload length */
-	u8 data[FT260_WR_DATA_MAX]; /* data payload */
+	__u8 report;		/* FT260_I2C_REPORT */
+	__u8 address;		/* 7-bit I2C address */
+	__u8 flag;		/* I2C transaction condition */
+	__u8 length;		/* data payload length */
+	__u8 data[FT260_WR_DATA_MAX]; /* data payload */
 } __packed;
 
 struct ft260_i2c_read_request_report {
-	u8 report;		/* FT260_I2C_READ_REQ */
-	u8 address;		/* 7-bit I2C address */
-	u8 flag;		/* I2C transaction condition */
+	__u8 report;		/* FT260_I2C_READ_REQ */
+	__u8 address;		/* 7-bit I2C address */
+	__u8 flag;		/* I2C transaction condition */
 	__le16 length;		/* data payload length */
 } __packed;
 
 struct ft260_input_report {
-	u8 report;		/* FT260_I2C_REPORT or FT260_UART_REPORT */
-	u8 length;		/* data payload length */
-	u8 data[2];		/* data payload */
+	__u8 report;		/* FT260_I2C_REPORT or FT260_UART_REPORT */
+	__u8 length;		/* data payload length */
+	__u8 data[2];		/* data payload */
 } __packed;
 
 static const struct hid_device_id ft260_devices[] = {
-- 
2.35.1

