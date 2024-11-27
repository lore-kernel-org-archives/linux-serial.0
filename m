Received: from mout.gmx.com (mout.gmx.com [74.208.4.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3731E139D
	for <linux-serial@vger.kernel.org>; Wed, 27 Nov 2024 03:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732677062; cv=none; b=XjA81RhYa1sszNbAKDd5Q/HvWQlNxpGIwQc7zwgzOV7ApKRy7cXNdU4z5gonQxNalbq/OM+N/CdBQcQGP/zpg2V6u8a8nlZK/A5DkHWMauheC2QkzxyMOsRXWkobDb61azU4f5C20AveQxC+7cdvYk1vqaTMpN6sJgX8myP0tFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732677062; c=relaxed/simple;
	bh=kfnryoaVkOxkpLmRV7+ZSyPcVeeKXjMgy1ZqE4eunQM=;
	h=MIME-Version:Message-ID:From:To:Subject:Content-Type:Date; b=kufj8/Xj947Y94autLcX/avsdlP/BJ/unAazqj0SwZ3pRh0qQNj74u6xBg5r6zGu/PmayCNUViqmz/QgFHNypouL62xrmBczYC15fQpDkQhTRGmOGPudIGmL9JrEdvoWwURGktq/kIK3iZQVl9MfwSf5gBY6Ln0cGQwWLUP2VwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.com; spf=pass smtp.mailfrom=mail.com; dkim=pass (2048-bit key) header.d=mail.com header.i=rozee@mail.com header.b=iR/NFwyK; arc=none smtp.client-ip=74.208.4.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mail.com header.i=rozee@mail.com header.b="iR/NFwyK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mail.com;
	s=s1089575; t=1732677059; x=1733281859; i=rozee@mail.com;
	bh=RgsXUH7mHHZaMEPOS2fYfjLHehFf72fBJzNn6qweIO0=;
	h=X-UI-Sender-Class:MIME-Version:Message-ID:From:To:Subject:
	 Content-Type:Date:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=iR/NFwyKSmM9rT5ICUBlkVawjLlCdCnY54jt5iOjCkcnnF2L9OiwB6kNOugXdkC2
	 Dxdm3tAVs/Vm0fJ7F8q4bK+fJxh+fSiItMCwg5QRIY4Ci3CEdx50CMRCGZpkqBvsY
	 RNgyXvNGPgmvyZ/htbPesE02+kGTP0gnSeMmxHPcYDA5/dWyvEsSK33c/r+Gsme+o
	 Ki5BKHnPNNxP3nEHl0CdWGPXf9Hn82FAYGtWRX256F5kFPHKvXyMtJ3xd+UEWgRwm
	 jQd5ljCodp44QDm6dbtCTBs/RiV6p8pLA4rxzHnvyD9j4mGXY7sQkJ/EvEzf+QhC5
	 r9JNY7P+sPfk1DO1ng==
X-UI-Sender-Class: f2cb72be-343f-493d-8ec3-b1efb8d6185a
Received: from [161.29.71.23] ([161.29.71.23]) by web-mail.mail.com
 (3c-app-mailcom-lxa13.server.lan [10.76.45.14]) (via HTTP); Wed, 27 Nov
 2024 04:10:59 +0100
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <trinity-50bc5494-0316-4897-ac6a-20d35eb795e8-1732677059152@3c-app-mailcom-lxa13>
From: robert rozee <rozee@mail.com>
To: linux-serial@vger.kernel.org
Subject: kernel 6.8 and checking serial ports - failure to match driver name
Content-Type: text/plain; charset=UTF-8
Date: Wed, 27 Nov 2024 04:10:59 +0100
Importance: normal
Sensitivity: Normal
Content-Transfer-Encoding: quoted-printable
X-Priority: 3
X-Provags-ID: V03:K1:wKhmMupOxiopuGLqGqsjmziDYH79vEfz5zlL8l57mrxkrZNS1myyhnND8yRPPrOjGBnL9
 MpYl+0UKewZ9BuMxCaLAZtu5GU1PGs9GvzDV4YQK/HJdbW9u4hV1CDrhUD2gvplV3PqnwZuV/J77
 y2Yd+ztj5V5vOkOEwW6dBZRmpJM0xa6ZDdLDd7/dt9jFSZvUPC2OJ1Dn0wuyuLF0dmiHj5b37y/v
 Wk77vraG83PUnEUOQkU+G/TMPlXUdsgAFZVTyhxaBD9orab8M6z8jX4iTrheOmcSq9Ek/OYPaQlx
 J4=
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:rqg8C9iaBp0=;1lDmYegkPQO8qERGmORuj7Q4/3d
 WG+xZ/x2uA0XQCDZrrXRA7UeuVkeSBCR9vkHfwD56oVTtWGo6J2GVwuqZ9DDWIspqwOIJd47G
 oUCFhSAyxkFrBzZcyPIK2JHR7Kpr3brwg2+5vrU7cjlNpYRGyX+1G4voliLz4oQJX9WTa1Pze
 1T3kfav3AE9opaQCacDskUdNUPObykGBrla1GVWuPMkIPiOb9c+udTAb6BS4pujVzCCYpruDp
 5WRYm8NCP1reE7ksJk7UMBoESNT1OLHKkBMq1qw1GKutXgDyEClgA6NX1fXiC2bxZ73K8N2aj
 dBuZ8n3CUUo+BOO3hJrBuf+MmBPMGoqOk73QQ8TrBaZ+Xsx8YISJc8wbIon7OaCPBSwXSYnwC
 PvChTbDCye3b9I7I/+W7nEWOVrdtYdi821/vgUzVqJhp5oshBjZmAsOdf+OmvB6Bi8JfxUDr1
 NYlzAywGFFAdOrQjgRyuvegNty8qzvNcT/sTh4yghKL1aD4f0EvfDvQm+bC8Qory216qb36T9
 F/HrxOnO93r/eE7SJTwN7tIDWphFlfje+ndGI3uSEFiaYgSTPRV8j0WysWS+Ilg2V5f9gCTq7
 VsQVqa9sChHq4Q6M5+61tz1U17r9SdRBRQcYlT955aZ+j94Ux0fNnS0/O4DV3dN3r8z4M5cwN
 Sws3pW88zRzKzFuuXvvXPnrd+RD6KrgnPjS46yMUrQ==

i'm having a problem with the 6=2E8 kernel, the driver associated with ttyS=
xx ports is not named serial8250 any more=2E put simply:

pre-6=2E8 kernel:
/sys/class/tty/ttySxx/device/driver resolves to /sys/bus/platform/drivers/=
serial8250

6=2E8 kernel:
/sys/class/tty/ttySxx/device/driver resolves to /sys/bus/serial-base/drive=
rs/port
=C2=A0
previously i had used the driver name being "serial8250" to make a decisio=
n on how to determine if a serial port needed to be queried with a TIOCGSER=
IAL ioctl call to find out if it was associated with real hardware; if the =
name was NOT "serial8250" then the serial port was assumed to exist, but if=
 the driver name was "serial8250" then an TIOCGSERIAL ioctl call needed to =
be made and the decision made on the basis of the returned 'type' (offset 0=
) being non-zero=2E

with the change in name from "serial8250" to "port" this no longer works=
=2E i am loathe to go ahead and make the decision based upon the name being=
 "port" in case deeper changes have been made in the kernel=2E can anyone p=
oint me in the direction of the right person to ask about this?

cheers,
rob   :-)
