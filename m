Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793099262;
	b=VM95deYVIJ57wo1RX+Fcdin4DSb9Ko0Pay3dwpt+4r6+SSnInz6gMlH1IUwpcz+pFrCp
	 uCeb4opJJBXgofQ8QsAu9Z2DaliAf5pEP22FMBBR5svzLI7gWYLGL1poI5cLTr8BV7W4F
	 7/driv3Z1MxhuNqAU84I9T3QpKyMErdRelrnOQG2kZ/64RwX8LoyQVhDV0sMiisNiyPH7
	 k9hynW08fSXLtTDwlqEFTU4vWDdR9AaqlbNoTQLe7KZysljwgwwzQly+ZSP/6FiVD2/W0
	 9ryJMIldRQ50cmrv5IPKgfLjHd5JJ93DlbyeVDtkI8aiTIQp97I1kybjrXnFh4tbwyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793099262;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=buI4Qt5MRZnNlVCTP2wVHcR3KhDDKPgLvdZ/HR1zU3I=;
	b=W+zVaZrztdTVZrfkCfSol/jbJ7I9+MiwdAsJSfVse5q8HJK1lJsc8H3Oopgs1YRdRfNO
	 gcuo2sweaEonQZaMiEa8gyDkAtel4nKTHcopQoD2jpfO0aBfr3r9Jd1vPigZXvDHJhx8W
	 at+cauT2PeFTgO+7nn2/dhcoApQ3frAD9s9Y85NPPWvfmlvaH0bj5+Uq/JIYENblp1/O2
	 IQ7l68bQWe/BVtXxGCHZMLJ50BhL3ujfUIqrBj//aTn1s0E4Mhm7ID7wp6eQcD/XlXoTq
	 bS2Gl5RvivIhTC7ux6KeNMw/ZTr4FvnnLzprUgGcWMABPKr5NWtfi957ZTKveMUKiOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=FrqZA0mS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944F3606E7ED;
	Tue, 27 Oct 2026 11:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=FrqZA0mS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C478F1F01829;
	Tue, 27 Oct 2026 11:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793099262;
	bh=buI4Qt5MRZnNlVCTP2wVHcR3KhDDKPgLvdZ/HR1zU3I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=FrqZA0mSpVqMgc6aD9WYenjHG2XSHA/FbVzzTQs1cXLK7Uc/fi3Jrc3Mcu7B3swQn
	 iOHIzAaxk4faWR8CL7Dbr3931wFRuefKuVIttNnYAiRn6RdHCQ7UI2SMu0FLgKIUjW
	 rs4JHBH2D3Pj3QqI7UJhVFHURZYkf0F/Jbx5ph+w=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Tue, 27 Oct 2026 12:06:48 +0100
Subject: [PATCH 22/24] serial: samsung: put the previous baud clock
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261027-tty-llm-v1-22-99b0202ae546@linuxfoundation.org>
References: <20261027-tty-llm-v1-0-99b0202ae546@linuxfoundation.org>
In-Reply-To: <20261027-tty-llm-v1-0-99b0202ae546@linuxfoundation.org>
To: Jiri Slaby <jirislaby@kernel.org>, Joshua Rogers <linux@joshua.hu>, 
 Chris Mason <mason@kernel.org>, Josef Bacik <josef@toxicpanda.com>
Cc: Tony Lindgren <tony@atomide.com>, Rafael Gago Castano <rgc@hms.se>, 
 Florian Fainelli <f.fainelli@gmail.com>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Peter Hurley <peter@hurleysoftware.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Crescent Hsieh <crescentcy.hsieh@moxa.com>, Frank Li <Frank.Li@nxp.com>, 
 Sherry Sun <sherry.sun@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Manivannan Sadhasivam <mani@kernel.org>, 
 Olof Johansson <olof@lixom.net>, 
 =?utf-8?q?Andreas_F=C3=A4rber?= <afaerber@suse.de>, 
 Arnd Bergmann <arnd@arndb.de>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Robert Baldyga <r.baldyga@samsung.com>, 
 Thomas Abraham <thomas.abraham@linaro.org>, 
 Kukjin Kim <kgene.kim@samsung.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Srinivas Kandagatla <srini@kernel.org>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Andy Shevchenko <andy.shevchenko@gmail.com>, 
 Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>, 
 Al Cooper <alcooperx@gmail.com>, linux-kernel@vger.kernel.org, 
 linux-serial@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable <stable@kernel.org>
X-Mailer: b4 0.17-dev-e5168
X-Developer-Signature: v=1; a=openpgp-sha256; l=1784;
 i=gregkh@linuxfoundation.org; h=from:subject:message-id;
 bh=/Wl84anFlTJD4CUqKP0cvUvUxS9O+Z37Q+o6ZWRmBdU=;
 b=owGbwMvMwCRo6H6F97bub03G02pJDFkPWvcHLN1XoiShLubLweMTol4TJMO53ifQ31H/Yv+zh
 KD9Bic7YlkYBJkYZMUUWb5s4zm6v+KQopeh7WmYOaxMIEMYuDgFYCI/PzPMFfLYtjYySeGEe8tv
 20r9m88nff63kGHBJTuuP43nzxl2K0mse2FuZVxS2/YBAA==
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp;
 fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29

From: Josef Bacik <josef@toxicpanda.com>

s3c24xx_serial_getclk() returns the best baud clock with the reference
which clk_get() has taken.  s3c24xx_serial_set_termios() stores it in
ourport->baudclk and disables the clock which was there before, but does
not put it.

clk_get() hands out a new handle on every call, so the new clock never
equals the old one, and every call of ->set_termios() leaks a handle: a
struct clk and a copy of the connection name.  Whoever has the port open
can repeat that at will with tcsetattr().

Put the old clock when it is replaced, and the new one in case it is not
stored.

Fixes: 5f5a7a5578c5 ("serial: samsung: switch to clkdev based clock lookup")
Cc: stable <stable@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Peter Griffin <peter.griffin@linaro.org>
Cc: Alim Akhtar <alim.akhtar@samsung.com>
Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: Kukjin Kim <kgene.kim@samsung.com>
Cc: Thomas Abraham <thomas.abraham@linaro.org>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/samsung_tty.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index c9a870a8d155..f437f7363fd3 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -1501,11 +1501,14 @@ static void s3c24xx_serial_set_termios(struct uart_port *port,
 
 		if (!IS_ERR(ourport->baudclk)) {
 			clk_disable_unprepare(ourport->baudclk);
+			clk_put(ourport->baudclk);
 			ourport->baudclk = ERR_PTR(-EINVAL);
 		}
 
 		ourport->baudclk = clk;
 		ourport->baudclk_rate = clk ? clk_get_rate(clk) : 0;
+	} else {
+		clk_put(clk);
 	}
 
 	if (ourport->info->has_divslot) {

-- 
2.56.0

