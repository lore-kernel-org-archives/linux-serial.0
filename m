From: Valentin Rothberg <valentinrothberg@gmail.com>
Subject: [PATCH 4/4] drivers/tty/serial/crisv10.c: rename CPP identifier CONFIG_ETRAX_SERX_DTR_RI_DSR_CD_MIXED
Date: Sat, 11 Apr 2015 15:56:03 +0200
Message-ID: <1428760563-13413-5-git-send-email-valentinrothberg@gmail.com>
References: <1428760563-13413-1-git-send-email-valentinrothberg@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1428760563-13413-1-git-send-email-valentinrothberg@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: starvik@axis.com, jesper.nilsson@axis.com, gregkh@linuxfoundation.org, jslaby@suse.cz, linux-cris-kernel@axis.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, pebolle@tiscali.nl
Cc: Valentin Rothberg <valentinrothberg@gmail.com>
List-Id: linux-serial@vger.kernel.org

The 'CONFIG_' prefix is reserved for Kconfig options in Make and CPP
syntax only.  Remove this prefix from the self-defined CPP identifier to
apply to this convention and make static analysis tools happy.

Signed-off-by: Valentin Rothberg <valentinrothberg@gmail.com>
---
 drivers/tty/serial/crisv10.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/crisv10.c b/drivers/tty/serial/crisv10.c
index 9ce6c1ce80b5..ad5b289ad2b1 100644
--- a/drivers/tty/serial/crisv10.c
+++ b/drivers/tty/serial/crisv10.c
@@ -708,10 +708,10 @@ static unsigned char dummy_ser[NR_PORTS] = {0xFF, 0xFF, 0xFF,0xFF};
     defined(CONFIG_ETRAX_SER1_DTR_RI_DSR_CD_MIXED) || \
     defined(CONFIG_ETRAX_SER2_DTR_RI_DSR_CD_MIXED) || \
     defined(CONFIG_ETRAX_SER3_DTR_RI_DSR_CD_MIXED)
-#define CONFIG_ETRAX_SERX_DTR_RI_DSR_CD_MIXED
+#define ETRAX_SERX_DTR_RI_DSR_CD_MIXED
 #endif
 
-#ifdef CONFIG_ETRAX_SERX_DTR_RI_DSR_CD_MIXED
+#ifdef ETRAX_SERX_DTR_RI_DSR_CD_MIXED
 /* The pins can be mixed on PA and PB */
 #define CONTROL_PINS_PORT_NOT_USED(line) \
   &dummy_ser[line], &dummy_ser[line], \
@@ -804,7 +804,7 @@ static const struct control_pins e100_modem_pins[NR_PORTS] =
 #endif
 	}
 };
-#else  /* CONFIG_ETRAX_SERX_DTR_RI_DSR_CD_MIXED */
+#else  /* ETRAX_SERX_DTR_RI_DSR_CD_MIXED */
 
 /* All pins are on either PA or PB for each serial port */
 #define CONTROL_PINS_PORT_NOT_USED(line) \
@@ -886,7 +886,7 @@ static const struct control_pins e100_modem_pins[NR_PORTS] =
 #endif
 	}
 };
-#endif /* !CONFIG_ETRAX_SERX_DTR_RI_DSR_CD_MIXED */
+#endif /* !ETRAX_SERX_DTR_RI_DSR_CD_MIXED */
 
 #define E100_RTS_MASK 0x20
 #define E100_CTS_MASK 0x40
-- 
2.1.0
