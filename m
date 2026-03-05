Received: from 3.mo581.mail-out.ovh.net (3.mo581.mail-out.ovh.net [46.105.34.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C973A5E8E
	for <linux-serial@vger.kernel.org>; Thu,  5 Mar 2026 13:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.105.34.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772718836; cv=none; b=BOFzQdIBmSwa04K/9jS97J1TQufSPV/ToVNO1y73xNzQKswiz7A2vpW9wkBLLy+dPbf9N82k9m10R8CA5HtUnAMpLDrVtKinKmD9KHfnmYUdoOcS+m+hWCCR/94P9n60243G1H7JeLb8qKHkhEs3s8FuipS+7L7IJ87tYymdo2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772718836; c=relaxed/simple;
	bh=tTjY5bp0iTm2WCvHOqhfSqQFJeTDlje+fkP7UD/PYN8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=IYxCZnBsQGKhzG1Kv9XHvZ2uVJYr6azltCyChVLXQ3q/nvCpL25MkJXoapvwrkqhQyIPC+b9n6jRSrjydiSxM8N1RoneMOFNbw7+ThdReZjr6XpnvxEu5Nzx1NyVNKYpIW/gwYGNggyepJVZKR/3QLgyNL5L6RZ0+SfwvFHMLlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=m-works.net; spf=pass smtp.mailfrom=m-works.net; arc=none smtp.client-ip=46.105.34.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=m-works.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=m-works.net
Received: from director10.ghost.mail-out.ovh.net (unknown [10.110.43.232])
	by mo581.mail-out.ovh.net (Postfix) with ESMTP id 4fRTb50qZTz6MsL
	for <linux-serial@vger.kernel.org>; Thu,  5 Mar 2026 12:37:53 +0000 (UTC)
Received: from ghost-submission-7d8d68f679-wdjj2 (unknown [10.110.118.54])
	by director10.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 5D555C284A;
	Thu,  5 Mar 2026 12:37:52 +0000 (UTC)
Received: from m-works.net ([37.59.142.109])
	by ghost-submission-7d8d68f679-wdjj2 with ESMTPSA
	id 6qY8OR95qWl+bhsArAFjuQ
	(envelope-from <maciej.andrzejewski@m-works.net>); Thu, 05 Mar 2026 12:37:52 +0000
Authentication-Results:garm.ovh; auth=pass (GARM-109S0032fe0d132-1f76-42ce-b129-39610cbfe1d1,
                    E291CFBA5258997C937E8CA829FF8FA8CC2CB86B) smtp.auth=maciej.andrzejewski@m-works.net
X-OVh-ClientIp:85.232.250.78
Date: Thu, 5 Mar 2026 13:37:51 +0100
From: Maciej Andrzejewski ICEYE <maciej.andrzejewski@m-works.net>
To: Peter Korsgaard <jacmet@sunsite.dk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	maciej.andrzejewski@m-works.net
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Maciej Andrzejewski ICEYE <maciej.andrzejewski@m-works.net>
Subject: [PATCH] serial: uartlite: fix PM runtime usage count underflow on
 probe
Message-ID: <20260305123746.4152800-1-maciej.andrzejewski@m-works.net>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.43.0
x-ovh-tracer-id: 8728257556967727907
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTE+BBN4ki3MZI6UJwwXPNXr7zQhdIUJFJhmPVn4bY1kqxTrnVqh3yPzi/yOrNJawXuQhB39ItU8158PVFKGLX2ZhRKSfN1qHtYtSL1ksSWLb4GHbJD/ofLRHtslEZCkIxKHauApY/5ia/qmyIFMzAo16R5zGVCFUA6c7gcqjo4kk9t+mawt/OgBmYCXpmV+EPnwzx2tiD8sVNkR7siUi9QHaKWeX6kIYA+zJQZBZZDa9l0NRJ+HxyoIDXNTT1HnDGg8NALUmMaDi0bezRsnyqaNwl8x0FicpK/DLGmZPgq5BUr0LoF1MynX2wZcm2G1gFUwvExcL/Lvelo9i/nfwmuaQor8MeJxVIO2qMVNfTfx97CIW4/xIRFhc/eNaIkA/SjJchR+EqtY7TKC9VRCdOXlvAju5ekCWlsSmTk362E+wNLFeHGrmwPWqNJg0nDGxgYEjy/dYZNLUy+Pa27wVoGWS6H6F8y/MOFH34Yr56qqz8qV6JVLPNm5bDRxXRXPmkjaIu1Nc/TkeOYHXov7ZOBFakbhDhfuVxEs/zjQX/Fvxnrou29XGOOGQayQ41vXcmOfrHlemZxCbA10Pfvd3Jn0iVI5QqukpBihzQShN9/fVhy5uX/qYmMrvYa+XQbncZFiNGtu3r0fZ+MjCb7QaaVhzVPFxh7szGGO+lQgaRB8WA

ulite_probe() calls pm_runtime_put_autosuspend() at the end of probe
without holding a corresponding PM runtime reference for non-console
ports.

During ulite_assign(), uart_add_one_port() triggers uart_configure_port()
which calls ulite_pm() via uart_change_pm(). For non-console ports, the
UART core performs a balanced get/put cycle:

  uart_change_pm(ON)  -> ulite_pm() -> pm_runtime_get_sync()        +1
  uart_change_pm(OFF) -> ulite_pm() -> pm_runtime_put_autosuspend() -1

This leaves no spare reference for the pm_runtime_put_autosuspend() at
the end of probe. The PM runtime core prevents the count from actually
going below zero, and instead triggers a
"Runtime PM usage count underflow!" warning.

For console ports the bug is masked: the UART core skips the
uart_change_pm(OFF) call, so the UART core's unbalanced get happens to
pair with probe's trailing put.

Add pm_runtime_get_noresume() before pm_runtime_enable() to take an
explicit probe-owned reference that the trailing
pm_runtime_put_autosuspend() can release. This ensures a correct usage
count regardless of whether the port is a console.

Fixes: 5bbe10a6942d ("tty: serial: uartlite: Add runtime pm support")
Cc: stable@vger.kernel.org
Signed-off-by: Maciej Andrzejewski ICEYE <maciej.andrzejewski@m-works.net>
---
 drivers/tty/serial/uartlite.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/uartlite.c b/drivers/tty/serial/uartlite.c
index 39c1fd1ff9ce..6240c3d4dfd7 100644
--- a/drivers/tty/serial/uartlite.c
+++ b/drivers/tty/serial/uartlite.c
@@ -878,6 +878,7 @@ static int ulite_probe(struct platform_device *pdev)
 	pm_runtime_use_autosuspend(&pdev->dev);
 	pm_runtime_set_autosuspend_delay(&pdev->dev, UART_AUTOSUSPEND_TIMEOUT);
 	pm_runtime_set_active(&pdev->dev);
+	pm_runtime_get_noresume(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
 
 	ret = ulite_assign(&pdev->dev, id, res->start, irq, pdata);
-- 
2.43.0
