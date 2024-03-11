Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED413A1BC
	for <linux-serial@vger.kernel.org>; Mon, 11 Mar 2024 11:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710156630; cv=none; b=d9l7z362SgT55CKhSq8ZdhpgXFEzo9suGISFK1qS3P1uPSLt1pvwTL/8Vixmd75wYUowuJ/1AKkKAayPLgyWxBsUibA2GTtmOWFrDKstZw/4Sq7E13hxzrsYNfGqO101x/Ahz3Z4FPiiD5dCUEXoPdSsvkaF22iOj6qTB240TJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710156630; c=relaxed/simple;
	bh=qM8hF6ZmRnBrmgXNks/rh7LqwkHDijbtSphZtiJE2U4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=udYgRj53MP0iyRPr5pl5ixzDE8e/1v3w50jkOLuVAFg41VBcId+dnnCbAZPx3Z1WJJua3tZYVrMBS74Dh4fix/5Mf58FcrvF/RRPCg/gJFuq5Ya2Cbfa5bwQNyoMk0Wv6UEFZZTpfarFUT0AA1oAR6vxPQpDsgKcF/BFRmE8K8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rjdrM-0007Fx-2C; Mon, 11 Mar 2024 12:30:24 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rjdrL-005hcG-Ed; Mon, 11 Mar 2024 12:30:23 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rjdrL-0040U5-19;
	Mon, 11 Mar 2024 12:30:23 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH] tty: vt: conmakehash: Don't mention the full path of the input in output
Date: Mon, 11 Mar 2024 12:30:18 +0100
Message-ID: <20240311113017.483101-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1866; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=qM8hF6ZmRnBrmgXNks/rh7LqwkHDijbtSphZtiJE2U4=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBl7utJG/3nW61SonsD5u0XPzPV6gvfi6dS9PiK1 oX4x13ZP0aJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZe7rSQAKCRCPgPtYfRL+ Tp/qB/9+4JB8AW8tepvkjnO+ROE4CRGaE4NbcDZlwYedjY2YaIIa4jFNPnLi3fONZwEO7rfWFAn MxBA+lQx8WgerLHGoAQscBfIe5yUr6Ot8OIbWqj6wQmHorJf0DqLMX6YkKghSm6+cBkDN8hp7l3 SDy/PhaKSbHynxt8yQqZCnYH6fVpcg9UBrqBBEo5N0s0fee+kA8SNl4SihkjUnOqGaRXqo+ApWz NhYJpAa1oHA43No7b9nET22xfShHLqT583SQiAgxM2Sk8K/HY7l8LaJPq4inO2KweGntMc9iTvc LyrqImhsCSDIhY+kVDBB34JCOrhsDNY6YkjfHBnXI0TVU1+z
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org

This change strips $abs_srctree of the input file containing the
character mapping table in the generated output. The motivation for this
change is Yocto emitting a build warning

        WARNING: linux-lxatac-6.7-r0 do_package_qa: QA Issue: File /usr/src/debug/linux-lxatac/6.7-r0/drivers/tty/vt/consolemap_deftbl.c in package linux-lxatac-src contains reference to TMPDIR

So this change brings us one step closer to make the build result
reproducible independent of the build path.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/tty/vt/conmakehash.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/vt/conmakehash.c b/drivers/tty/vt/conmakehash.c
index cddd789fe46e..dc2177fec715 100644
--- a/drivers/tty/vt/conmakehash.c
+++ b/drivers/tty/vt/conmakehash.c
@@ -76,7 +76,8 @@ static void addpair(int fp, int un)
 int main(int argc, char *argv[])
 {
   FILE *ctbl;
-  char *tblname;
+  const char *tblname, *rel_tblname;
+  const char *abs_srctree;
   char buffer[65536];
   int fontlen;
   int i, nuni, nent;
@@ -101,6 +102,16 @@ int main(int argc, char *argv[])
 	}
     }
 
+  abs_srctree = getenv("abs_srctree");
+  if (abs_srctree && !strncmp(abs_srctree, tblname, strlen(abs_srctree)))
+    {
+      rel_tblname = tblname + strlen(abs_srctree);
+      while (*rel_tblname == '/')
+	++rel_tblname;
+    }
+  else
+    rel_tblname = tblname;
+
   /* For now we assume the default font is always 256 characters. */
   fontlen = 256;
 
@@ -253,7 +264,7 @@ int main(int argc, char *argv[])
 #include <linux/types.h>\n\
 \n\
 u8 dfont_unicount[%d] = \n\
-{\n\t", argv[1], fontlen);
+{\n\t", rel_tblname, fontlen);
 
   for ( i = 0 ; i < fontlen ; i++ )
     {

base-commit: 8ffc8b1bbd505e27e2c8439d326b6059c906c9dd
-- 
2.43.0

