Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E16155C91;
	Mon,  5 Aug 2024 10:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722853257; cv=none; b=gj2gmaW8HkfbrcgMD6awngfGPL9u/fmZekBqt73lCUGOizkt7HF+GY3u/8eIZdflbiZM/p7diu6pD8lCGL9zqDFXPPEq/N6o0rZYSDkHkrAcucocJ8oSRZJ+9axWeFFGxUPhckymgvzo8PHeOCpke+U3YWJkppkxNiP61iNwz8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722853257; c=relaxed/simple;
	bh=n4v5gmWtmqYQInKnJ/Js6GzVrvaIyNCeY/904bJqLK8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PF6DTOErLTa4RK1UEdzh50Sv4pTG3bM0bdTNiADsjLNjgOUb5YnRozQOkYZiSnwhEbDaxf2LbZi938ebhQO4/E3mSEzkbI8zuv8Qd8phomJHhAgky2bJrTVF7fHAotqo7UHFWdLbwmaXFly7gCB5u+yMvoWdiwZcMEC2bNdFX4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YWsw0LvP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YWsw0LvP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03DEDC4AF0D;
	Mon,  5 Aug 2024 10:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722853257;
	bh=n4v5gmWtmqYQInKnJ/Js6GzVrvaIyNCeY/904bJqLK8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YWsw0LvPLdgFkGHOZy8F4Nh7/wtWSTrTPl2QPrRpyGngvna126B98z0g1q3VJvKhV
	 32pgQUcb4d78RpOvLH1RYkZhrzALxtmnGFvuq0A1/DpVTf+8Z8WaduFkoREIDdrDLQ
	 WECgYryvu3tNlbkQWL+p2bWF/sDoQPQdUjyR3eafW7rJgGY/CGxY0Gl9q58+xrKjZX
	 K8v/AaPNpIcFPUkXZIKgsd7dbA712/eR0HPGQU7uojF8XR+I49LB6zzxKpjv6+5Ibu
	 iZH038xKggv+FZE0W45Kl8BijJFTQ67gwq2QQWs2z1jVU+Ru4FWhAtQIKhEWeegQVv
	 xQX4NbNKzADxg==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	stable@vger.kernel.org,
	Douglas Anderson <dianders@chromium.org>
Subject: [PATCH 03/13] serial: don't use uninitialized value in uart_poll_init()
Date: Mon,  5 Aug 2024 12:20:36 +0200
Message-ID: <20240805102046.307511-4-jirislaby@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240805102046.307511-1-jirislaby@kernel.org>
References: <20240805102046.307511-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Coverity reports (as CID 1536978) that uart_poll_init() passes
uninitialized pm_state to uart_change_pm(). It is in case the first 'if'
takes the true branch (does "goto out;").

Fix this and simplify the function by simple guard(mutex). The code
needs no labels after this at all. And it is pretty clear that the code
has not fiddled with pm_state at that point.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Fixes: 5e227ef2aa38 (serial: uart_poll_init() should power on the UART)
Cc: stable@vger.kernel.org
Cc: Douglas Anderson <dianders@chromium.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/serial_core.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 3afe77f05abf..d63e9b636e02 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -2690,14 +2690,13 @@ static int uart_poll_init(struct tty_driver *driver, int line, char *options)
 	int ret = 0;
 
 	tport = &state->port;
-	mutex_lock(&tport->mutex);
+
+	guard(mutex)(&tport->mutex);
 
 	port = uart_port_check(state);
 	if (!port || port->type == PORT_UNKNOWN ||
-	    !(port->ops->poll_get_char && port->ops->poll_put_char)) {
-		ret = -1;
-		goto out;
-	}
+	    !(port->ops->poll_get_char && port->ops->poll_put_char))
+		return -1;
 
 	pm_state = state->pm_state;
 	uart_change_pm(state, UART_PM_STATE_ON);
@@ -2717,10 +2716,10 @@ static int uart_poll_init(struct tty_driver *driver, int line, char *options)
 		ret = uart_set_options(port, NULL, baud, parity, bits, flow);
 		console_list_unlock();
 	}
-out:
+
 	if (ret)
 		uart_change_pm(state, pm_state);
-	mutex_unlock(&tport->mutex);
+
 	return ret;
 }
 
-- 
2.46.0

