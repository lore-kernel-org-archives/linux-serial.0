Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793099205;
	b=tb5Q6RLebHoRjIyx6rzw/t7XWSp6g5hDhb6N6074ik1Nb/NDqsBxviOih/H4Lrmoa4p4
	 NKopoZNaDLfqhYHApRIDm6qqjQxldxHRar9qQi3htJlXV9aOctkccRuW1nOExnp/PcbzY
	 iLvtQTVhxGF3s0/CJfqlbsHo7jbNaD/17T3JdE6U2rcVYh34nUKcS90DHxHLSf5hN1C/2
	 Ppoa0zl8U9d4nhtdBvGUlEdhVGeEhM0m96L+IIBiHhBJAiJ8FN1ikUgg0Nh4boTdFkQjl
	 f1IjOd8GThOc31RIoXWc5Qf9LpvDj9CtF2QWwY7dNwuxmiPjUHsXzegCgIVIJubxoGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793099205;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=w9JLcxkekk0SoKUL41CSq+wR9dQesJmZqPkBcLIUo7E=;
	b=anCkJz7WsGQgkclArJtIGKaLM8Nv/mU+kt0JBajjIe3DoMinyMeKj9ZZTSwLFRlvag7G
	 1RUXzwzIRadgEjEg9v9ffiBShDKCwBX0PGIZGbwt01qE/FW/3AWR8G0ZFlj0tp6ODxtpa
	 TjmBWrsiQY84E+/U4qJ32nX2tlQsRPTeMYXALAzjDHano+mCM1A/JDCtQIo+p/pbXj02E
	 l6ImO8cLDuOCq+oF8Nz1eqD5d9zTxGqudbBnCfmtz+77NPu27h2MbPcC91vOa1B+a2e24
	 5ihdBfahVJyT77291Yacn+fQnsYHkzLYBFqeRbAweiIkytqvRQIFN2nnpw0M1QdvfBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=xZ2icfri;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23021606A328;
	Tue, 27 Oct 2026 11:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=xZ2icfri
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E23491F031EA;
	Tue, 27 Oct 2026 11:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793099204;
	bh=w9JLcxkekk0SoKUL41CSq+wR9dQesJmZqPkBcLIUo7E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=xZ2icfri0/AhA+F2EVSIvmG1mbhP38w//2Tqx2HRy57OSEAgIXcRPzdTqtf1ViRjc
	 gny4BwNQV8hnjCBxfo0ZwI75Nsv5OXAcPbvD86McYna47PxbtOcdJ3NgcuvZh5+JPW
	 uQn/bCnUh4xdFmndrfzEQpaNmCSDpPLrH7IEIx80=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Tue, 27 Oct 2026 12:06:27 +0100
Subject: [PATCH 01/24] vt: serialise the producers of the flip buffer
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
Message-Id: <20261027-tty-llm-v1-1-99b0202ae546@linuxfoundation.org>
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
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable <stable@kernel.org>, 
 Nicolas Pitre <npitre@baylibre.com>, Kees Cook <kees+treewide@kernel.org>, 
 Helge Deller <deller@gmx.de>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Mingyu Wang <25181214217@stu.xidian.edu.cn>, 
 Randy Dunlap <rdunlap@infradead.org>, Ronan Pigott <ronan@rjp.ie>, 
 Liav Mordouch <liavmordouch@gmail.com>
X-Mailer: b4 0.17-dev-e5168
X-Developer-Signature: v=1; a=openpgp-sha256; l=4768;
 i=gregkh@linuxfoundation.org; h=from:subject:message-id;
 bh=jR9+7jjCyJvPoC7RXU4XKwVay/7TvtwUACG4NhQYRPU=;
 b=owGbwMvMwCRo6H6F97bub03G02pJDFkPWvfGr0v/HfuyYm624k8h7V3pM+d7CkW9sQvPv+x7Z
 3sFS6dIRywLgyATg6yYIsuXbTxH91ccUvQytD0NM4eVCWQIAxenAEwkwpdhnnL/eUVlk9oF0yW6
 99epfss8HhUczzBPaWVhRpOydtLxCNVS8abqpedu+pcBAA==
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp;
 fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29

From: Chris Mason <mason@kernel.org>

Typing on a virtual console while the console replies to an escape
sequence can make the kernel write past the end of a buffer. A user who
can write to the foreground console can cause this on purpose if they
can also inject key events, through /dev/uinput or by writing to the
/dev/input/event* node of a keyboard.

Input for a tty goes through the flip buffer of its port. A driver
inserts the data with tty_insert_flip_*() and then calls
tty_flip_buffer_push() to pass it on to the line discipline. The insert
functions take no lock: they check that the current struct tty_buffer
has room, copy the data to offset ->used, and then advance ->used. So a
flip buffer supports only one producer at a time, and a driver that has
several must serialise them.

Four functions feed the flip buffer of a virtual console:

- put_queue(), puts_queue() and fn_send_intr() insert typed characters
  and breaks for the keyboard handler. They run under kbd_event_lock.
- respond_string() inserts the reply when a program writes an escape
  sequence that requests one, such as a cursor position report. It runs
  under the console lock.

The keyboard handler gets its events from the input layer and feeds the
foreground console. Key events that a program writes to /dev/uinput or
to an event node reach it in the same way as typed keys.

The keyboard handler and respond_string() share no lock, so they can
interleave:

    keyboard handler                respond_string()
    ================                ================
    room check passes
                                    room check passes
    memcpy() to offset used
    used += len
                                    memcpy() to offset used
                                    used += len
                                      /* used > size of the buffer */

The room check subtracts ->used from the size, and both are unsigned.
Once ->used exceeds the size, the result wraps, so the check always
passes, and each later insert lands further past the buffer.

Reproduced as root, with keys from a uinput keyboard and cursor position
reports on the same console: KFENCE reported an out-of-bounds write
1,024 bytes past the buffer in under 10 s.

Fix this by taking port->lock, with interrupts disabled, around the
insert and the push in these four functions. kbd_keycode() already takes
port->lock under kbd_event_lock, so this lock ordering is not new.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable <stable@kernel.org>
Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: Nicolas Pitre <npitre@baylibre.com>
Cc: Kees Cook <kees+treewide@kernel.org>
Cc: Joshua Rogers <linux@joshua.hu>
Cc: Chris Mason <mason@kernel.org>
Cc: Helge Deller <deller@gmx.de>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Mingyu Wang <25181214217@stu.xidian.edu.cn>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Ronan Pigott <ronan@rjp.ie>
Cc: Liav Mordouch <liavmordouch@gmail.com>
Signed-off-by: Chris Mason <mason@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/vt/keyboard.c | 6 ++++++
 drivers/tty/vt/vt.c       | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
index ef4a19aeb3ce..f4b742e091fb 100644
--- a/drivers/tty/vt/keyboard.c
+++ b/drivers/tty/vt/keyboard.c
@@ -322,15 +322,20 @@ int kbd_rate(struct kbd_repeat *rpt)
 
 /*
  * Helper Functions.
+ *
+ * A flip buffer allows one producer at a time, and respond_string() in vt.c
+ * feeds the same one under the console lock. So take the lock of the port.
  */
 static void put_queue(struct vc_data *vc, int ch)
 {
+	guard(spinlock_irqsave)(&vc->port.lock);
 	tty_insert_flip_char(&vc->port, ch, 0);
 	tty_flip_buffer_push(&vc->port);
 }
 
 static void puts_queue(struct vc_data *vc, const char *cp)
 {
+	guard(spinlock_irqsave)(&vc->port.lock);
 	tty_insert_flip_string(&vc->port, cp, strlen(cp));
 	tty_flip_buffer_push(&vc->port);
 }
@@ -587,6 +592,7 @@ static void fn_inc_console(struct vc_data *vc)
 
 static void fn_send_intr(struct vc_data *vc)
 {
+	guard(spinlock_irqsave)(&vc->port.lock);
 	tty_insert_flip_char(&vc->port, 0, TTY_BREAK);
 	tty_flip_buffer_push(&vc->port);
 }
diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 8415e274e4be..5c2c761aa0c1 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -1971,6 +1971,8 @@ static void csi_m(struct vc_data *vc)
 
 static void respond_string(const char *p, size_t len, struct tty_port *port)
 {
+	/* The keyboard handler feeds the same flip buffer. */
+	guard(spinlock_irqsave)(&port->lock);
 	tty_insert_flip_string(port, p, len);
 	tty_flip_buffer_push(port);
 }

-- 
2.56.0

