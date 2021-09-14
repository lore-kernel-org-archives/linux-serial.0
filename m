Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 263D1C4332F
	for <linux-serial@archiver.kernel.org>; Tue, 14 Sep 2021 09:14:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FD0461056
	for <linux-serial@archiver.kernel.org>; Tue, 14 Sep 2021 09:14:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbhINJPi (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 14 Sep 2021 05:15:38 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:34538 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbhINJPg (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 14 Sep 2021 05:15:36 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id C7F53220D3;
        Tue, 14 Sep 2021 09:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1631610857; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lefCdGCBb2IKxvnUXZv+qZIzzpLyiLa7K/Wg3U6dwD8=;
        b=dVw+kFFImhNTxDqEJFcpkzlSg7U1qVrLX3DCXA0NZ7HZ6YsPR2FOLJ7z3vOoISQ4EuzX5/
        zRK5HlY/1e2KZ+eDWz1NyFpTDECx5K8a4/4muz9x6uzx0NaZHtYlhUpLc/4gytNjaHc0YN
        adJ0hqZ9EvF3gmuywjJ1n1u/9508UA0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1631610857;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lefCdGCBb2IKxvnUXZv+qZIzzpLyiLa7K/Wg3U6dwD8=;
        b=FBK3SovZClqB+NzxxFZe7yysA6LJ8fTKxsrICOsH1ggTKgR68Jk8TKIiTxhf8QWNEf2YIm
        ZPLZX50Lr0OLWWCA==
Received: from localhost.localdomain (unknown [10.100.201.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id A1E87A3B96;
        Tue, 14 Sep 2021 09:14:17 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>, Johan Hovold <johan@kernel.org>,
        linux-usb@vger.kernel.org
Subject: [PATCH 10/16] tty: drivers/usb/serial/, stop using tty_flip_buffer_push
Date:   Tue, 14 Sep 2021 11:14:09 +0200
Message-Id: <20210914091415.17918-3-jslaby@suse.cz>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210914091415.17918-1-jslaby@suse.cz>
References: <20210914091134.17426-1-jslaby@suse.cz>
 <20210914091415.17918-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Since commit a9c3f68f3cd8d (tty: Fix low_latency BUG) in 2014,
tty_flip_buffer_push() is only a wrapper to tty_schedule_flip(). We are
going to remove the former, so call the latter directly in
drivers/usb/serial/.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Johan Hovold <johan@kernel.org>
Cc: linux-usb@vger.kernel.org
---
 drivers/usb/serial/aircable.c         |  2 +-
 drivers/usb/serial/ark3116.c          |  2 +-
 drivers/usb/serial/belkin_sa.c        |  2 +-
 drivers/usb/serial/cp210x.c           |  2 +-
 drivers/usb/serial/cyberjack.c        |  2 +-
 drivers/usb/serial/cypress_m8.c       |  2 +-
 drivers/usb/serial/digi_acceleport.c  |  2 +-
 drivers/usb/serial/f81232.c           |  4 ++--
 drivers/usb/serial/f81534.c           |  2 +-
 drivers/usb/serial/ftdi_sio.c         |  2 +-
 drivers/usb/serial/garmin_gps.c       |  2 +-
 drivers/usb/serial/generic.c          |  2 +-
 drivers/usb/serial/io_edgeport.c      |  2 +-
 drivers/usb/serial/io_ti.c            |  2 +-
 drivers/usb/serial/ir-usb.c           |  2 +-
 drivers/usb/serial/iuu_phoenix.c      |  2 +-
 drivers/usb/serial/keyspan.c          | 10 +++++-----
 drivers/usb/serial/keyspan_pda.c      |  2 +-
 drivers/usb/serial/kl5kusb105.c       |  2 +-
 drivers/usb/serial/kobil_sct.c        |  2 +-
 drivers/usb/serial/mct_u232.c         |  2 +-
 drivers/usb/serial/metro-usb.c        |  2 +-
 drivers/usb/serial/mos7720.c          |  2 +-
 drivers/usb/serial/mos7840.c          |  2 +-
 drivers/usb/serial/mxuport.c          |  2 +-
 drivers/usb/serial/navman.c           |  2 +-
 drivers/usb/serial/omninet.c          |  2 +-
 drivers/usb/serial/opticon.c          |  2 +-
 drivers/usb/serial/oti6858.c          |  2 +-
 drivers/usb/serial/pl2303.c           |  2 +-
 drivers/usb/serial/quatech2.c         |  4 ++--
 drivers/usb/serial/safe_serial.c      |  2 +-
 drivers/usb/serial/sierra.c           |  2 +-
 drivers/usb/serial/ssu100.c           |  2 +-
 drivers/usb/serial/symbolserial.c     |  2 +-
 drivers/usb/serial/ti_usb_3410_5052.c |  2 +-
 drivers/usb/serial/usb_wwan.c         |  2 +-
 37 files changed, 43 insertions(+), 43 deletions(-)

diff --git a/drivers/usb/serial/aircable.c b/drivers/usb/serial/aircable.c
index a1df686c3066..762f1183c965 100644
--- a/drivers/usb/serial/aircable.c
+++ b/drivers/usb/serial/aircable.c
@@ -133,7 +133,7 @@ static void aircable_process_read_urb(struct urb *urb)
 	}
 
 	if (count)
-		tty_flip_buffer_push(&port->port);
+		tty_schedule_flip(&port->port);
 }
 
 static struct usb_serial_driver aircable_device = {
diff --git a/drivers/usb/serial/ark3116.c b/drivers/usb/serial/ark3116.c
index 5dd710e9fe7d..bf891eeb4d06 100644
--- a/drivers/usb/serial/ark3116.c
+++ b/drivers/usb/serial/ark3116.c
@@ -605,7 +605,7 @@ static void ark3116_process_read_urb(struct urb *urb)
 	}
 	tty_insert_flip_string_fixed_flag(&port->port, data, tty_flag,
 							urb->actual_length);
-	tty_flip_buffer_push(&port->port);
+	tty_schedule_flip(&port->port);
 }
 
 static struct usb_serial_driver ark3116_device = {
diff --git a/drivers/usb/serial/belkin_sa.c b/drivers/usb/serial/belkin_sa.c
index 8107e4b5b03b..fa715d8f5232 100644
--- a/drivers/usb/serial/belkin_sa.c
+++ b/drivers/usb/serial/belkin_sa.c
@@ -269,7 +269,7 @@ static void belkin_sa_process_read_urb(struct urb *urb)
 
 	tty_insert_flip_string_fixed_flag(&port->port, data, tty_flag,
 							urb->actual_length);
-	tty_flip_buffer_push(&port->port);
+	tty_schedule_flip(&port->port);
 }
 
 static void belkin_sa_set_termios(struct tty_struct *tty,
diff --git a/drivers/usb/serial/cp210x.c b/drivers/usb/serial/cp210x.c
index 66a6ac50a4cd..c934f5173fbf 100644
--- a/drivers/usb/serial/cp210x.c
+++ b/drivers/usb/serial/cp210x.c
@@ -939,7 +939,7 @@ static void cp210x_process_read_urb(struct urb *urb)
 	} else {
 		tty_insert_flip_string(&port->port, ch, urb->actual_length);
 	}
-	tty_flip_buffer_push(&port->port);
+	tty_schedule_flip(&port->port);
 }
 
 /*
diff --git a/drivers/usb/serial/cyberjack.c b/drivers/usb/serial/cyberjack.c
index 51e5aac3bf4c..9a5a3c0427c5 100644
--- a/drivers/usb/serial/cyberjack.c
+++ b/drivers/usb/serial/cyberjack.c
@@ -322,7 +322,7 @@ static void cyberjack_read_bulk_callback(struct urb *urb)
 
 	if (urb->actual_length) {
 		tty_insert_flip_string(&port->port, data, urb->actual_length);
-		tty_flip_buffer_push(&port->port);
+		tty_schedule_flip(&port->port);
 	}
 
 	spin_lock_irqsave(&priv->lock, flags);
diff --git a/drivers/usb/serial/cypress_m8.c b/drivers/usb/serial/cypress_m8.c
index 6924fa95f6bd..db6f150c12c0 100644
--- a/drivers/usb/serial/cypress_m8.c
+++ b/drivers/usb/serial/cypress_m8.c
@@ -1128,7 +1128,7 @@ static void cypress_read_int_callback(struct urb *urb)
 	if (bytes > i) {
 		tty_insert_flip_string_fixed_flag(&port->port, data + i,
 				tty_flag, bytes - i);
-		tty_flip_buffer_push(&port->port);
+		tty_schedule_flip(&port->port);
 	}
 
 	spin_lock_irqsave(&priv->lock, flags);
diff --git a/drivers/usb/serial/digi_acceleport.c b/drivers/usb/serial/digi_acceleport.c
index af65eb863d70..a47f9a412b8a 100644
--- a/drivers/usb/serial/digi_acceleport.c
+++ b/drivers/usb/serial/digi_acceleport.c
@@ -1416,7 +1416,7 @@ static int digi_read_inb_callback(struct urb *urb)
 		if (len > 0) {
 			tty_insert_flip_string_fixed_flag(&port->port, data,
 					tty_flag, len);
-			tty_flip_buffer_push(&port->port);
+			tty_schedule_flip(&port->port);
 		}
 	}
 	spin_unlock_irqrestore(&priv->dp_port_lock, flags);
diff --git a/drivers/usb/serial/f81232.c b/drivers/usb/serial/f81232.c
index a7a7af8d05bf..1e13f9abc66a 100644
--- a/drivers/usb/serial/f81232.c
+++ b/drivers/usb/serial/f81232.c
@@ -428,7 +428,7 @@ static void f81232_process_read_urb(struct urb *urb)
 		tty_insert_flip_char(&port->port, data[i + 1], tty_flag);
 	}
 
-	tty_flip_buffer_push(&port->port);
+	tty_schedule_flip(&port->port);
 }
 
 static void f81534a_process_read_urb(struct urb *urb)
@@ -469,7 +469,7 @@ static void f81534a_process_read_urb(struct urb *urb)
 							tty_flag, len - 2);
 	}
 
-	tty_flip_buffer_push(&port->port);
+	tty_schedule_flip(&port->port);
 }
 
 static void f81232_break_ctl(struct tty_struct *tty, int break_state)
diff --git a/drivers/usb/serial/f81534.c b/drivers/usb/serial/f81534.c
index c0bca52ef92a..78da1c5805d1 100644
--- a/drivers/usb/serial/f81534.c
+++ b/drivers/usb/serial/f81534.c
@@ -1239,7 +1239,7 @@ static void f81534_process_per_serial_block(struct usb_serial_port *port,
 		tty_insert_flip_char(&port->port, data[i], tty_flag);
 	}
 
-	tty_flip_buffer_push(&port->port);
+	tty_schedule_flip(&port->port);
 }
 
 static void f81534_process_read_urb(struct urb *urb)
diff --git a/drivers/usb/serial/ftdi_sio.c b/drivers/usb/serial/ftdi_sio.c
index 99d19828dae6..c47121d704b9 100644
--- a/drivers/usb/serial/ftdi_sio.c
+++ b/drivers/usb/serial/ftdi_sio.c
@@ -2603,7 +2603,7 @@ static void ftdi_process_read_urb(struct urb *urb)
 	}
 
 	if (count)
-		tty_flip_buffer_push(&port->port);
+		tty_schedule_flip(&port->port);
 }
 
 static void ftdi_break_ctl(struct tty_struct *tty, int break_state)
diff --git a/drivers/usb/serial/garmin_gps.c b/drivers/usb/serial/garmin_gps.c
index e5c75944ebb7..79a6f0f646a5 100644
--- a/drivers/usb/serial/garmin_gps.c
+++ b/drivers/usb/serial/garmin_gps.c
@@ -245,7 +245,7 @@ static void send_to_tty(struct usb_serial_port *port,
 	if (actual_length) {
 		usb_serial_debug_data(&port->dev, __func__, actual_length, data);
 		tty_insert_flip_string(&port->port, data, actual_length);
-		tty_flip_buffer_push(&port->port);
+		tty_schedule_flip(&port->port);
 	}
 }
 
diff --git a/drivers/usb/serial/generic.c b/drivers/usb/serial/generic.c
index 15b6dee3a8e5..0ff57b3479b0 100644
--- a/drivers/usb/serial/generic.c
+++ b/drivers/usb/serial/generic.c
@@ -363,7 +363,7 @@ void usb_serial_generic_process_read_urb(struct urb *urb)
 	} else {
 		tty_insert_flip_string(&port->port, ch, urb->actual_length);
 	}
-	tty_flip_buffer_push(&port->port);
+	tty_schedule_flip(&port->port);
 }
 EXPORT_SYMBOL_GPL(usb_serial_generic_process_read_urb);
 
diff --git a/drivers/usb/serial/io_edgeport.c b/drivers/usb/serial/io_edgeport.c
index bdee78cc4a07..ee13f8159132 100644
--- a/drivers/usb/serial/io_edgeport.c
+++ b/drivers/usb/serial/io_edgeport.c
@@ -1876,7 +1876,7 @@ static void edge_tty_recv(struct usb_serial_port *port, unsigned char *data,
 	data += cnt;
 	length -= cnt;
 
-	tty_flip_buffer_push(&port->port);
+	tty_schedule_flip(&port->port);
 }
 
 
diff --git a/drivers/usb/serial/io_ti.c b/drivers/usb/serial/io_ti.c
index a7b3c15957ba..b2ea8b0136bd 100644
--- a/drivers/usb/serial/io_ti.c
+++ b/drivers/usb/serial/io_ti.c
@@ -1794,7 +1794,7 @@ static void edge_tty_recv(struct usb_serial_port *port, unsigned char *data,
 	if (queued < length)
 		dev_err(&port->dev, "%s - dropping data, %d bytes lost\n",
 			__func__, length - queued);
-	tty_flip_buffer_push(&port->port);
+	tty_schedule_flip(&port->port);
 }
 
 static void edge_bulk_out_callback(struct urb *urb)
diff --git a/drivers/usb/serial/ir-usb.c b/drivers/usb/serial/ir-usb.c
index 7b44dbea95cd..120d9104c027 100644
--- a/drivers/usb/serial/ir-usb.c
+++ b/drivers/usb/serial/ir-usb.c
@@ -372,7 +372,7 @@ static void ir_process_read_urb(struct urb *urb)
 		return;
 
 	tty_insert_flip_string(&port->port, data + 1, urb->actual_length - 1);
-	tty_flip_buffer_push(&port->port);
+	tty_schedule_flip(&port->port);
 }
 
 static void ir_set_termios(struct tty_struct *tty,
diff --git a/drivers/usb/serial/iuu_phoenix.c b/drivers/usb/serial/iuu_phoenix.c
index 0be3b5e1eaf3..c18da8faadf5 100644
--- a/drivers/usb/serial/iuu_phoenix.c
+++ b/drivers/usb/serial/iuu_phoenix.c
@@ -590,7 +590,7 @@ static void read_buf_callback(struct urb *urb)
 
 	if (urb->actual_length) {
 		tty_insert_flip_string(&port->port, data, urb->actual_length);
-		tty_flip_buffer_push(&port->port);
+		tty_schedule_flip(&port->port);
 	}
 	iuu_led_activity_on(urb);
 }
diff --git a/drivers/usb/serial/keyspan.c b/drivers/usb/serial/keyspan.c
index 87b89c99d517..0524b64326fa 100644
--- a/drivers/usb/serial/keyspan.c
+++ b/drivers/usb/serial/keyspan.c
@@ -810,7 +810,7 @@ static void	usa26_indat_callback(struct urb *urb)
 						flag);
 			}
 		}
-		tty_flip_buffer_push(&port->port);
+		tty_schedule_flip(&port->port);
 	}
 
 	/* Resubmit urb so we continue receiving */
@@ -936,7 +936,7 @@ static void usa28_indat_callback(struct urb *urb)
 		if (urb->actual_length) {
 			tty_insert_flip_string(&port->port, data,
 					urb->actual_length);
-			tty_flip_buffer_push(&port->port);
+			tty_schedule_flip(&port->port);
 		}
 
 		/* Resubmit urb so we continue receiving */
@@ -1154,7 +1154,7 @@ static void	usa49_indat_callback(struct urb *urb)
 						flag);
 			}
 		}
-		tty_flip_buffer_push(&port->port);
+		tty_schedule_flip(&port->port);
 	}
 
 	/* Resubmit urb so we continue receiving */
@@ -1225,7 +1225,7 @@ static void usa49wg_indat_callback(struct urb *urb)
 				i += 2;
 			}
 		}
-		tty_flip_buffer_push(&port->port);
+		tty_schedule_flip(&port->port);
 	}
 
 	/* Resubmit urb so we continue receiving */
@@ -1301,7 +1301,7 @@ static void usa90_indat_callback(struct urb *urb)
 				}
 			}
 		}
-		tty_flip_buffer_push(&port->port);
+		tty_schedule_flip(&port->port);
 	}
 
 	/* Resubmit urb so we continue receiving */
diff --git a/drivers/usb/serial/keyspan_pda.c b/drivers/usb/serial/keyspan_pda.c
index 39b0f5f344c2..b0f482854289 100644
--- a/drivers/usb/serial/keyspan_pda.c
+++ b/drivers/usb/serial/keyspan_pda.c
@@ -190,7 +190,7 @@ static void keyspan_pda_rx_interrupt(struct urb *urb)
 		if (len < 2)
 			break;
 		tty_insert_flip_string(&port->port, data + 1, len - 1);
-		tty_flip_buffer_push(&port->port);
+		tty_schedule_flip(&port->port);
 		break;
 	case 1:
 		/* status interrupt */
diff --git a/drivers/usb/serial/kl5kusb105.c b/drivers/usb/serial/kl5kusb105.c
index f1e9628a9907..8931f427e557 100644
--- a/drivers/usb/serial/kl5kusb105.c
+++ b/drivers/usb/serial/kl5kusb105.c
@@ -388,7 +388,7 @@ static void klsi_105_process_read_urb(struct urb *urb)
 	}
 
 	tty_insert_flip_string(&port->port, data + KLSI_HDR_LEN, len);
-	tty_flip_buffer_push(&port->port);
+	tty_schedule_flip(&port->port);
 }
 
 static void klsi_105_set_termios(struct tty_struct *tty,
diff --git a/drivers/usb/serial/kobil_sct.c b/drivers/usb/serial/kobil_sct.c
index 4ed8b8b0a361..44f73db45e19 100644
--- a/drivers/usb/serial/kobil_sct.c
+++ b/drivers/usb/serial/kobil_sct.c
@@ -276,7 +276,7 @@ static void kobil_read_int_callback(struct urb *urb)
 		usb_serial_debug_data(&port->dev, __func__, urb->actual_length,
 									data);
 		tty_insert_flip_string(&port->port, data, urb->actual_length);
-		tty_flip_buffer_push(&port->port);
+		tty_schedule_flip(&port->port);
 	}
 
 	result = usb_submit_urb(port->interrupt_in_urb, GFP_ATOMIC);
diff --git a/drivers/usb/serial/mct_u232.c b/drivers/usb/serial/mct_u232.c
index ecd5b921e374..bb7eedd63a76 100644
--- a/drivers/usb/serial/mct_u232.c
+++ b/drivers/usb/serial/mct_u232.c
@@ -538,7 +538,7 @@ static void mct_u232_read_int_callback(struct urb *urb)
 		if (urb->actual_length) {
 			tty_insert_flip_string(&port->port, data,
 					urb->actual_length);
-			tty_flip_buffer_push(&port->port);
+			tty_schedule_flip(&port->port);
 		}
 		goto exit;
 	}
diff --git a/drivers/usb/serial/metro-usb.c b/drivers/usb/serial/metro-usb.c
index 30ab565e0738..6f7927dc3198 100644
--- a/drivers/usb/serial/metro-usb.c
+++ b/drivers/usb/serial/metro-usb.c
@@ -141,7 +141,7 @@ static void metrousb_read_int_callback(struct urb *urb)
 		tty_insert_flip_string(&port->port, data, urb->actual_length);
 
 		/* Force the data to the tty layer. */
-		tty_flip_buffer_push(&port->port);
+		tty_schedule_flip(&port->port);
 	}
 
 	/* Set any port variables. */
diff --git a/drivers/usb/serial/mos7720.c b/drivers/usb/serial/mos7720.c
index 227f43d2bd56..f00088343b04 100644
--- a/drivers/usb/serial/mos7720.c
+++ b/drivers/usb/serial/mos7720.c
@@ -782,7 +782,7 @@ static void mos7720_bulk_in_callback(struct urb *urb)
 
 	if (urb->actual_length) {
 		tty_insert_flip_string(&port->port, data, urb->actual_length);
-		tty_flip_buffer_push(&port->port);
+		tty_schedule_flip(&port->port);
 	}
 
 	if (port->read_urb->status != -EINPROGRESS) {
diff --git a/drivers/usb/serial/mos7840.c b/drivers/usb/serial/mos7840.c
index d7fe33ca73e4..16e5cfa322ca 100644
--- a/drivers/usb/serial/mos7840.c
+++ b/drivers/usb/serial/mos7840.c
@@ -451,7 +451,7 @@ static void mos7840_bulk_in_callback(struct urb *urb)
 	if (urb->actual_length) {
 		struct tty_port *tport = &mos7840_port->port->port;
 		tty_insert_flip_string(tport, data, urb->actual_length);
-		tty_flip_buffer_push(tport);
+		tty_schedule_flip(tport);
 		port->icount.rx += urb->actual_length;
 		dev_dbg(&port->dev, "icount.rx is %d:\n", port->icount.rx);
 	}
diff --git a/drivers/usb/serial/mxuport.c b/drivers/usb/serial/mxuport.c
index eb45a9b0005c..32885e31e27d 100644
--- a/drivers/usb/serial/mxuport.c
+++ b/drivers/usb/serial/mxuport.c
@@ -329,7 +329,7 @@ static void mxuport_process_read_urb_data(struct usb_serial_port *port,
 	} else {
 		tty_insert_flip_string(&port->port, data, size);
 	}
-	tty_flip_buffer_push(&port->port);
+	tty_schedule_flip(&port->port);
 }
 
 static void mxuport_msr_event(struct usb_serial_port *port, u8 buf[4])
diff --git a/drivers/usb/serial/navman.c b/drivers/usb/serial/navman.c
index 20277c52dded..296cb07f438c 100644
--- a/drivers/usb/serial/navman.c
+++ b/drivers/usb/serial/navman.c
@@ -52,7 +52,7 @@ static void navman_read_int_callback(struct urb *urb)
 
 	if (urb->actual_length) {
 		tty_insert_flip_string(&port->port, data, urb->actual_length);
-		tty_flip_buffer_push(&port->port);
+		tty_schedule_flip(&port->port);
 	}
 
 exit:
diff --git a/drivers/usb/serial/omninet.c b/drivers/usb/serial/omninet.c
index 41f1b872d277..f984b3cc2ca0 100644
--- a/drivers/usb/serial/omninet.c
+++ b/drivers/usb/serial/omninet.c
@@ -149,7 +149,7 @@ static void omninet_process_read_urb(struct urb *urb)
 	data_len = min_t(size_t, urb->actual_length - OMNINET_HEADERLEN,
 								hdr->oh_len);
 	tty_insert_flip_string(&port->port, data, data_len);
-	tty_flip_buffer_push(&port->port);
+	tty_schedule_flip(&port->port);
 }
 
 static int omninet_prepare_write_buffer(struct usb_serial_port *port,
diff --git a/drivers/usb/serial/opticon.c b/drivers/usb/serial/opticon.c
index aed28c35caff..844f0bc04336 100644
--- a/drivers/usb/serial/opticon.c
+++ b/drivers/usb/serial/opticon.c
@@ -51,7 +51,7 @@ static void opticon_process_data_packet(struct usb_serial_port *port,
 					const unsigned char *buf, size_t len)
 {
 	tty_insert_flip_string(&port->port, buf, len);
-	tty_flip_buffer_push(&port->port);
+	tty_schedule_flip(&port->port);
 }
 
 static void opticon_process_status_packet(struct usb_serial_port *port,
diff --git a/drivers/usb/serial/oti6858.c b/drivers/usb/serial/oti6858.c
index a5caedbe72e2..0abfd07d80e7 100644
--- a/drivers/usb/serial/oti6858.c
+++ b/drivers/usb/serial/oti6858.c
@@ -780,7 +780,7 @@ static void oti6858_read_bulk_callback(struct urb *urb)
 
 	if (urb->actual_length > 0) {
 		tty_insert_flip_string(&port->port, data, urb->actual_length);
-		tty_flip_buffer_push(&port->port);
+		tty_schedule_flip(&port->port);
 	}
 
 	/* schedule the interrupt urb */
diff --git a/drivers/usb/serial/pl2303.c b/drivers/usb/serial/pl2303.c
index 930b3d50a330..84a63885cda5 100644
--- a/drivers/usb/serial/pl2303.c
+++ b/drivers/usb/serial/pl2303.c
@@ -1211,7 +1211,7 @@ static void pl2303_process_read_urb(struct urb *urb)
 							urb->actual_length);
 	}
 
-	tty_flip_buffer_push(&port->port);
+	tty_schedule_flip(&port->port);
 }
 
 static struct usb_serial_driver pl2303_device = {
diff --git a/drivers/usb/serial/quatech2.c b/drivers/usb/serial/quatech2.c
index 971907f083a3..e1a44cfd88b1 100644
--- a/drivers/usb/serial/quatech2.c
+++ b/drivers/usb/serial/quatech2.c
@@ -521,7 +521,7 @@ static void qt2_process_read_urb(struct urb *urb)
 						 __func__);
 					break;
 				}
-				tty_flip_buffer_push(&port->port);
+				tty_schedule_flip(&port->port);
 
 				newport = *(ch + 3);
 
@@ -560,7 +560,7 @@ static void qt2_process_read_urb(struct urb *urb)
 		tty_insert_flip_char(&port->port, *ch, TTY_NORMAL);
 	}
 
-	tty_flip_buffer_push(&port->port);
+	tty_schedule_flip(&port->port);
 }
 
 static void qt2_write_bulk_callback(struct urb *urb)
diff --git a/drivers/usb/serial/safe_serial.c b/drivers/usb/serial/safe_serial.c
index 6accbecb6318..be239d61abc2 100644
--- a/drivers/usb/serial/safe_serial.c
+++ b/drivers/usb/serial/safe_serial.c
@@ -217,7 +217,7 @@ static void safe_process_read_urb(struct urb *urb)
 	length = actual_length;
 out:
 	tty_insert_flip_string(&port->port, data, length);
-	tty_flip_buffer_push(&port->port);
+	tty_schedule_flip(&port->port);
 }
 
 static int safe_prepare_write_buffer(struct usb_serial_port *port,
diff --git a/drivers/usb/serial/sierra.c b/drivers/usb/serial/sierra.c
index 9d56138133a9..ba61c0832151 100644
--- a/drivers/usb/serial/sierra.c
+++ b/drivers/usb/serial/sierra.c
@@ -538,7 +538,7 @@ static void sierra_indat_callback(struct urb *urb)
 		if (urb->actual_length) {
 			tty_insert_flip_string(&port->port, data,
 				urb->actual_length);
-			tty_flip_buffer_push(&port->port);
+			tty_schedule_flip(&port->port);
 
 			usb_serial_debug_data(&port->dev, __func__,
 					      urb->actual_length, data);
diff --git a/drivers/usb/serial/ssu100.c b/drivers/usb/serial/ssu100.c
index 3baf7c0f5a98..3ded890d6347 100644
--- a/drivers/usb/serial/ssu100.c
+++ b/drivers/usb/serial/ssu100.c
@@ -509,7 +509,7 @@ static void ssu100_process_read_urb(struct urb *urb)
 		tty_insert_flip_string_fixed_flag(&port->port, ch, flag, len);
 	}
 
-	tty_flip_buffer_push(&port->port);
+	tty_schedule_flip(&port->port);
 }
 
 static struct usb_serial_driver ssu100_device = {
diff --git a/drivers/usb/serial/symbolserial.c b/drivers/usb/serial/symbolserial.c
index d7f73ad6e778..ed375af3a294 100644
--- a/drivers/usb/serial/symbolserial.c
+++ b/drivers/usb/serial/symbolserial.c
@@ -68,7 +68,7 @@ static void symbol_int_callback(struct urb *urb)
 		if (data_length > (urb->actual_length - 1))
 			data_length = urb->actual_length - 1;
 		tty_insert_flip_string(&port->port, &data[1], data_length);
-		tty_flip_buffer_push(&port->port);
+		tty_schedule_flip(&port->port);
 	} else {
 		dev_dbg(&port->dev, "%s - short packet\n", __func__);
 	}
diff --git a/drivers/usb/serial/ti_usb_3410_5052.c b/drivers/usb/serial/ti_usb_3410_5052.c
index 18c0bd853392..fcb3fa636660 100644
--- a/drivers/usb/serial/ti_usb_3410_5052.c
+++ b/drivers/usb/serial/ti_usb_3410_5052.c
@@ -1275,7 +1275,7 @@ static void ti_recv(struct usb_serial_port *port, unsigned char *data,
 			if (cnt == 0)
 				break;
 		}
-		tty_flip_buffer_push(&port->port);
+		tty_schedule_flip(&port->port);
 		data += cnt;
 		length -= cnt;
 	} while (length > 0);
diff --git a/drivers/usb/serial/usb_wwan.c b/drivers/usb/serial/usb_wwan.c
index cb01283d4d15..c793548c0edf 100644
--- a/drivers/usb/serial/usb_wwan.c
+++ b/drivers/usb/serial/usb_wwan.c
@@ -233,7 +233,7 @@ static void usb_wwan_indat_callback(struct urb *urb)
 		if (urb->actual_length) {
 			tty_insert_flip_string(&port->port, data,
 					urb->actual_length);
-			tty_flip_buffer_push(&port->port);
+			tty_schedule_flip(&port->port);
 		} else
 			dev_dbg(dev, "%s: empty read urb received\n", __func__);
 	}
-- 
2.33.0

