Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=78.133.224.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793743660;
	b=Ry5LFA1yn1dU7t9XkASlfEqphPKX8kyh15w9VHKDt/jgCJG/E5YdplFd0QhLe+awEXBt
	 pdpKORLmscdDtd/j/jM4qxDeJXnlgmNTv3bpRXw5p9va9Oea/dgYbRYQzpA7vt/KZIrr3
	 /dKXekLCGf/eI9+EGmWatSifUz4aLjxte4CO9Kl3JEwEP7aiCb3pUAMiUfUWg+cmmQ188
	 CIsv3D4OLHztYJeDISTlrsxvOadiZkGW0r5YyQ4UfbnbjvKDRm9L3e1nzAvtnQsK3p6rO
	 4tI6Tpu/Fcqcp8lUruP1xWCa9bqBGRYEZM4QuHzKj7t6z9GvRPOU+E9+g0KexDMWf9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793743660;
	h=DMARC-Filter:Received:Received:Date:From:To:cc:Subject:Message-ID:
	 User-Agent:MIME-Version:Content-Type:Content-ID;
	bh=VRZz5fKKW6ooM6/DvuNbWQ+ouWa9aojakmYV2s8rNGQ=;
	b=Kuk9pxs7biPwcLrD382VPO/iSPcTJH+2J7rI8tY2zC5GXvjy8VaayYO/XsmHdtp3OvCe
	 S3YCsHeGxhTawppfuBtMqmrZco+vtZnhN+GfAM8umPMIsnkE4Cm3EUSGtzEdMf8UPbr6p
	 kawvLyGPU4An4kfGUZAovetTYpsSfSnISzilg7lpFWvHRZcE4Hqajm+d7zEbT80aKP+0X
	 0bPuIfxYcTnL2vtYgnsvxA0HJqcqXsRYII6/G29dUdRwt8BhEddmkAV7t/7rKHnuaptV0
	 wKXu4AM/YYiQ8KZLAU9Y91sXtCvne0NMDSYmcDMi2YXeJNQ9FQshHRLWD6ciTDgix3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=orcam.me.uk;
	spf=none smtp.mailfrom=orcam.me.uk;
	arc=none smtp.remote-ip=78.133.224.34
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF1B5606A329;
	Tue,  3 Nov 2026 22:07:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF1B5606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id BC57F92009E; Tue,  3 Nov 2026 23:07:36 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id B5B3992009C;
	Tue,  3 Nov 2026 22:07:36 +0000 (GMT)
Date: Tue, 3 Nov 2026 22:07:36 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>
cc: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
    =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>, 
    Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
    Crescent Hsieh <crescentcy.hsieh@moxa.com>, 
    Hugo Villeneuve <hvilleneuve@dimonoff.com>, 
    Johan Hovold <johan@kernel.org>, John Ogness <john.ogness@linutronix.de>, 
    Karl Mehltretter <kmehltretter@gmail.com>, linux-kernel@vger.kernel.org, 
    linux-serial@vger.kernel.org
Subject: [PATCH v3 0/2] serial: core: Don't clobber the baud rate on hangup
 via B0
Message-ID: <alpine.DEB.2.21.2611030057510.15685@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="-2058476832-1101985018-1793667572=:15685"
Content-ID: <alpine.DEB.2.21.2611030100160.15685@angie.orcam.me.uk>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---2058476832-1101985018-1793667572=:15685
Content-Type: text/plain; CHARSET=US-ASCII
Content-ID: <alpine.DEB.2.21.2611030100161.15685@angie.orcam.me.uk>

Greg,

 This is v3 of the change for device baud rate preservation where the B0 
rate has been requested for hangup that we discussed at LPC.

 Following the observations regarding v2 I have now excluded the 8250 
console restoration path from rewriting port->hup_speed; this path only 
takes the most recent baud rate previously set and reinstates it with 
hardware without changing the setting chosen.  See the individual patches 
for further details of the changes made.

 I have verified it with the system and driver originally affected, that 
is a Broadcom BCM91250A "SWARM" system and sb1250-duart driver, but now 
also an MTI Malta system and the 8250 driver, with both showing the same 
symptoms on real hardware (worth mentioning since Malta is commonly used 
emulated in QEMU); cf. SIBYTE_SWARM and MIPS_MALTA in arch/mips/Kconfig.  
I have retained the console output logs previously attached for the bad vs 
fixed case; output is virtually the same across both systems.

 All that needed to be done to reproduce it was to keep killing getty(8)s 
repeatedly until init(8) decided something was wrong and chose to put 
their inittab(5) entries into a snooze, leaving the line(s) at the wrong 
speed setting.  I have done further experimentation with actual kernel 
console output by issuing:

# echo h >/proc/sysrq-trigger

once the console port has been hung up and that obviously also produced 
corrupt output without the fix and correct output with the fix applied.

 I have no means to verify the serial8250_console_restore() path; the fix 
is expected to make no functional change there.

 Since the return path from uart_get_baud_rate() has become more complex 
now than just supplying the baud rate chosen to the caller I went back to 
the original idea of having this as a small patch series, where 1/2 merely 
merges the two successful return paths into one.

 NB this fixes the missing %B0 literal markup as a part of the doc update.  
I've concluded it's not worth splitting off into a separate patch.  Let me 
know if you think otherwise.

 Previous iterations:

- v2 at: <https://lore.kernel.org/r/alpine.DEB.2.21.2610120150230.55767@angie.orcam.me.uk/>.

- v1 at: <https://lore.kernel.org/r/alpine.DEB.2.21.2605242242330.1450@angie.orcam.me.uk/>.

  Maciej
---2058476832-1101985018-1793667572=:15685
Content-Type: text/plain; CHARSET=US-ASCII; NAME=swarm-bad.log
Content-Transfer-Encoding: BASE64
Content-ID: <alpine.DEB.2.21.2611030059320.15685@angie.orcam.me.uk>
Content-Description: 
Content-Disposition: ATTACHMENT; FILENAME=swarm-bad.log

G1tIG1tKDXN3YXJtLm9yY2FtLm1lLnVrIGxvZ2luOiAA/gD+AAAAAAAA/gAA
8AAA8AD+AADwAADwAP4A/gAA8AAA8AD+AAAAwAD+AP4A/gAA8AD+AADwAAAA
AAAAAPgAAPAA/gAA8AAA8AD+AAAAwAAA8AD+AAAAAAAAAPgAAPAAAPAAAADA
AADwAP4AAPAA/gD+AAAAAAAA/gAA8AAA8AAAAMAAAPAAAAAAAAAA+AAA8AAA
8AAA8AD+AP4A/gAA8AD+AP4AAPAA/gAAAAAAAP4A/gD+AAAAAAAA/gD+AP4A
/gAA8AD+AP4A/gAA8AD+AP4AAPAA/gD+AP4AAPAA/gAAAAAAAADwAADwAAAA
wAD+AP4A/gD+AP4A/gD+AP4AAAAAAAAA8AAA8AAA8AAA8AD+AP4AAAAAAAD+
AP4AAPAA/gAAAMAA/gD+AADwAP4AAPAAAAAAAAAA8AAA8AAAAMAAAPAA/gD+
AADwAP4A/gD+AADwAP4A/gAAAAAAAP4AAPAAAADAAP4AAADAAP4A/gD+AP4A
APAA/gAAAMAAAPAA/gAAAAAAAAD4AADwAADwAADwAP4A/gD+AP4AAPAAAPAA
/gAAAAAAAAD4AADwAP4A/gD+AADwAAAAAAAAAPgAAPAA/gD+AP4A/gD+AADw
AP4A/gAA8AD+AP4A/gD+AP4A/gAAAMAA/gD+AP4A/gAA8AD+AP4AAPAA/gD+
AP4AAAAAAAAA8AD+AAAAAAAA/gD+AAAAAAAA/gAA8AAA8AD+AADwAADwAP4A
/gAA8AAA8AD+AAAAwAD+AP4A/gAA8AD+AADwAAAAAAAAAPgAAPAA/gAA8AAA
8AD+AAAAwAAA8AD+AAAAAAAAAPAAAPAAAPAAAADAAADwAP4AAPAA/gD+AP4A
AADAAADwAADwAAAAwAAA8AAAAAAAAADwAADwAADwAADwAP4A/gD+AADwAP4A
/gAA8AD+AAAAAAAA/gD+AP4AAAAAAAD+AP4A/gD+AADwAP4A/gD+AADwAP4A
/gAA8AD+AP4A/gAA8AD+AAAAAAAAAPgAAPAAAADAAP4A/gD+AP4A/gD+AP4A
/gAAAAAAAAD4AADwAADwAADwAP4A/gAAAAAAAP4A/gAA8AD+AAAAwAD+AP4A
APAA/gAA8AAAAAAAAAD4AADwAAAAwAAA8AD+AP4AAPAA/gD+AP4AAPAA/gD+
AAAAAAAA/gAA8AAAAMAA/gAAAMAA/gD+AP4A/gAA8AD+AAAAwAAA8AD+AAAA
AAAAAPAAAPAAAPAAAPAA/gD+AP4A/gAA8AAA8AD+AAAAAAAAAPAAAPAA/gD+
AP4AAPAAAAAAAAAA+AAA8AD+AP4A/gD+AP4AAPAA/gD+AADwAP4A/gD+AP4A
/gD+AAAAwAD+AP4A/gD+AADwAP4A/gAA8AD+AP4A/gAAAAAAAADwAP4AAAAA
AAD+AP4AAAAAAAD+AADwAADwAP4AAPAAAPAA/gD+AADwAADwAP4AAADAAP4A
/gD+AADwAP4AAPAAAAAAAAAA8AAA8AAA8AD+AP4A/gD+AP4AAAAAAAAA+AAA
8AD+AP4A/gD+AP4A/gD+AADwAADwAP4A/gD+AADwAP4AAAAAAAAA+AAA8AAA
AAAAAP4A/gAA8AAA8AD+AP4A/gD+AP4AAADAAP4A/gD+AADwAP4A/gAA8AD+
AP4AAPAA/gD+AP4AAPAA/gD+AADwAP4AAAAAAAAA+AAA8AAAAMAA/gD+AP4A
/gAA8AD+AADwAADwAP4AAADAAP4A/gAAAAAAAADwAADwAP4AAPAA/gD+AADw
AP4A/gAAAAAAAADwAADwAAAAwAD+AP4AAAAAAAD+AP4A/gAA8AD+AP4A/gAA
8AD+AAAAAAAAAPgAAPAAAPAAAPAA/gD+AP4A/gD+AADwAP4A/gAAAMAA/gD+
AP4A/gAA8AD+AADwAP4A/gD+AP4AAPAA/gAAAMAA/gD+AP4A/gAAAAAAAADw
AP4AAAAAABtbSBtbSg1zd2FybS5vcmNhbS5tZS51ayBsb2dpbjogDQo=

---2058476832-1101985018-1793667572=:15685
Content-Type: text/plain; CHARSET=US-ASCII; NAME=swarm-fixed.log
Content-Transfer-Encoding: BASE64
Content-ID: <alpine.DEB.2.21.2611030059321.15685@angie.orcam.me.uk>
Content-Description: 
Content-Disposition: ATTACHMENT; FILENAME=swarm-fixed.log

G1tIG1tKc3dhcm0ub3JjYW0ubWUudWsgbG9naW46IElOSVQ6IElkICJTMCIg
cmVzcGF3bmluZyB0b28gZmFzdDogZGlzYWJsZWQgZm9yIDUgbWludXRlcw0K
SU5JVDogSWQgIlMxIiByZXNwYXduaW5nIHRvbyBmYXN0OiBkaXNhYmxlZCBm
b3IgNSBtaW51dGVzDQpJTklUOiBubyBtb3JlIHByb2Nlc3NlcyBsZWZ0IGlu
IHRoaXMgcnVubGV2ZWwNChtbSBtbSnN3YXJtLm9yY2FtLm1lLnVrIGxvZ2lu
OiANCg==

---2058476832-1101985018-1793667572=:15685--
