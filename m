Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2AA4477FB
	for <linux-serial@vger.kernel.org>; Tue,  4 Aug 2026 08:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785833913; cv=none; b=bjfFTQoFSm9S4ipml8m00ff7VGt7+9n+fwYkXn7dFSis+qz8hpynmgrveVUXlrAwfvjpyv7c7xSlCH9mfiuvULLC8+tZBEoCDGicf9fPW1ttBzPmt6S/f81Hq06ei6i3FO5yUWZIxbH3PnHitaABsNAbOyxCG2SylbneBJDWCPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785833913; c=relaxed/simple;
	bh=T4T8J6kQtOfKpFrainH/0lAWtwbLoAzsPxkzmb7Aui4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I226XvUOuzA9LKPettP2zkqM6M8+odvpg19JhjP77uk2MRnl3foHvGhyZoLlj9/VWkkmQRustdu/kF/Csbq+vtzlCUGiGK3yAkrUsTqjNdOLQl2vwGdbdzAW9XD+IHNi8t9RCDJB3og8SBQ9UaLxkgQTpDTEsd+l8stiJzYJ/N0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=I5tuoObo; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="I5tuoObo"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4955de8797cso18323075e9.3
        for <linux-serial@vger.kernel.org>; Tue, 04 Aug 2026 01:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1785833909; x=1786438709; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9cVOemErjRgu9665gh0KIaMpm/ugAOnpqNqqlw0YTGk=;
        b=I5tuoOboUDiT9gCmz7nEQL6YVbNiS79PUmymdtyLXmIgAGwAMJp9tCLH49Pugy2g5h
         5EetPqLYQU7a7ad68tCPL8av/7nlEu2TiwlKKY/q1xpqZx48Kue/wqgRweRBYct1FazV
         hMpT4NBfMIsR22jcGeh0xvAZW8pP144INOA49paeADIpb/zkL/WWTYglOoFDiLOCp8xN
         EKPyYv+pzzDmEFviZATrBDE8IEcAJ/Z3cAkRB3WYhB+DcbbrxtDkplRaNb47uiXlzBsa
         BmrkzALM6F+Pj+TDyQWYUTyyQyjNte7nhAQoTNCuFi3DLAC0CnRHf/IvTMrMscyW0ZSR
         oxgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785833909; x=1786438709;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9cVOemErjRgu9665gh0KIaMpm/ugAOnpqNqqlw0YTGk=;
        b=qiBzU8FcBXW6wGpP5/Z6txXzKjpD4LTfhAB5YtmYFQqgJnLi9H7chzamZ7u7XFwNHA
         W1w5l5VSoMOklVPLvqENJ/hSTHC0IAy8EYDv/UDB9dvzLdNRSBsehcSkASRZQ5TDmyJ/
         grryqEvkjxTggyhV0aa4kSPKj171qQWXWZ8yv06m2UkvMfk3BX0OpeiNt+fKkdmT8kYY
         g2Hsj48rDKW8serEQZsq4/6mI4fhwkr1d+4Ck2WErpjTTi7jk19nvTMsl2m2h+Cni5Om
         /KDIYbZPwdsw3b9giovFNj/b4rpbojbJLvy/GywdndbOiqq+I+ePUapNWfE85/pAkQBT
         ziyA==
X-Forwarded-Encrypted: i=1; AHgh+RoNvAqRKZG3wPrUwH0X798ObsVdrhF06RTptM7Oya2DqMSD2VB3FlFIUd9RML5P1KU/QWyX/wz1Je/N5sY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBkThrzt/H89r/niGbojRAYuIXDUJkRuFrj+0e7OovmuMYWsIZ
	SQ+7tIxy+b3AWkSnne1qUgUeeA2cjkqKTC5/DddDdbbDMWTfKxB8iVNuweM3/TcxiL0=
X-Gm-Gg: AR+sD13RTxhH5VIiMJJLaJBpnBKTTfUNKsY0fk64aEsSxvzfoHIawQ3ODKjHZv7pT2B
	McwGp5ySWTmRjqojykfE+6OQr0M58KrMITd3DgYSzS6cSBqlDO9xpvxRo6xeU83cCsAMimrJDww
	Xwd5yvrekaE9ZvLBznkP9VOTnuRI3/gN4rCLtt0uD9onG2f68/kP6ZJQOmeHE+a7vocw857e6sx
	AmNEQAh1ATfmiCk1DukvIYjRvpq78XLmD0UlQvXUKg3jJnUea1QcUv6t+0JbKkqNGN6hqFl+YqH
	0jm4PCuy8OAOon90H0K2/ojL89CBHEOkOkij5IYF4cqnmoPZbVpnXFqSRFHDGEdIj+F5Zy2i4Bt
	67WMQHVeuKICS2u/QmqDVQc+dqD/1rFp9O0EgVEyyCy4wjhbjMlGYC595P8ImCSyxbwUe0XjLnv
	xTumxrQlQx5pgwQO5dK0Jzv8Bjib8JK9mGxkan+o8YxLZXT7r9QAAln1u6aiyIfnjo1GnBQn0VC
	2cuQiZR17NCGYi001A0EZuvgmU8g4qvyFDxp1nQsS/bYRVwjL+f
X-Received: by 2002:a05:600c:524a:b0:493:bd2a:93be with SMTP id 5b1f17b1804b1-4980eb5cb45mr283753395e9.6.1785833909415;
        Tue, 04 Aug 2026 01:58:29 -0700 (PDT)
Received: from localhost (p200300f65f01710496a76592f11363a3.dip0.t-ipconnect.de. [2003:f6:5f01:7104:96a7:6592:f113:63a3])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-49807b4d8absm137603905e9.0.2026.08.04.01.58.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 01:58:29 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	John Ogness <john.ogness@linutronix.de>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH v2 3/8] serial: txx9: Drop usage of uart_match_port()
Date: Tue,  4 Aug 2026 10:57:55 +0200
Message-ID:  <35779acb88c9507af9ac68bc026070bbc20b33a6.1785832297.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.55.0.11.g153666a7d9bb
In-Reply-To: <cover.1785832297.git.u.kleine-koenig@baylibre.com>
References: <cover.1785832297.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=966; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=T4T8J6kQtOfKpFrainH/0lAWtwbLoAzsPxkzmb7Aui4=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqcamZK3gLHTQoOXTf3aRd9dAJv276/odcoMYDe 6eR9ySb82eJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCanGpmQAKCRCPgPtYfRL+ To7BB/97B9HGZvwsJg26L8Nk4yWcxo5pNx3xqaRtDYsM2m4ISQmeoCQrUcyRUliupXclXbiEHin ZtjNRN8gBqg095jKwjPtW6nEeWp9Dnn9xwNVBRrORh4ExOQoeT7mveAafHrHkKCktXgBFjxN1MQ iImepL5PgA9NV/csJXHxEmmjmeFeMrNe0pZ+9lKRC90CPXeL3DdGEj9P0nF8OLdzvvjMQBnS7kG 1XiHxLkzXh66x/b631IXRdOSRTXkckLfnckxb8tQJTFEO/r5quDzAkIu3Lc1/ZPsjRHAe9leJG0 pkgS+f1YW2MMZ/v3i1Fi+7T1vhl/T9z96GGAa6WqlAs8Zhg9
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

In the txx9 driver .iotype is always UPIO_PORT. So uart_match_port() is
equivalent to comparing .iobase. Remove the call to uart_match_port()
which then only has a single caller that is handled in the next commit.

Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
 drivers/tty/serial/serial_txx9.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/serial_txx9.c b/drivers/tty/serial/serial_txx9.c
index bda7f7527b8d..8febc0549f76 100644
--- a/drivers/tty/serial/serial_txx9.c
+++ b/drivers/tty/serial/serial_txx9.c
@@ -911,7 +911,7 @@ static int serial_txx9_register_port(struct uart_port *port)
 	mutex_lock(&serial_txx9_mutex);
 	for (i = 0; i < UART_NR; i++) {
 		uart = &serial_txx9_ports[i];
-		if (uart_match_port(uart, port)) {
+		if (uart->iobase == port->iobase) {
 			uart_remove_one_port(&serial_txx9_reg, uart);
 			break;
 		}
-- 
2.55.0.11.g153666a7d9bb

