Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E3D3CE489;
	Mon, 12 Oct 2026 19:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791835089; cv=none; b=FN9X0akVBHzrmsZsPEZ2YtrxJQ0TYRZHa/YerZmNsPwmi9Z/v8kcBY2rpp2Sb6wfLGHZqhm9kVstmk0WHrvBruwhgTpqtQqy4vmYHo4y8mS7ROH/HM0BGgrMfFSCDG5S+Gb8ZejFQv+ST1G6bztuyCQn5ss5n8QH9ed1NwXxUGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791835089; c=relaxed/simple;
	bh=N5wVf6huEusiIDNk/5c7GdFjensv5aDGIBXaan7le38=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=GHyi2PORWQXnhlwSRD2Xwty9Eq13hjpMfZto2WinocpIQZ1lblOR1+4R2u6mzfJjiJfq19scnU4ShhlRu9BHuZyii3FFHd2pRjb5YUEwCSIBo+fv0IcsGMjjHg7LIR69NRS88zMhfG4HDJGl3CPsRrmOmLVr1IlWhT1DQNZ03F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gregoirelayet.com; spf=pass smtp.mailfrom=gregoirelayet.com; dkim=pass (2048-bit key) header.d=gregoirelayet.com header.i=@gregoirelayet.com header.b=PF8ax70J; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gregoirelayet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gregoirelayet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gregoirelayet.com header.i=@gregoirelayet.com header.b="PF8ax70J"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4j3Stq0Bq7zKncP;
	Mon, 12 Oct 2026 21:57:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gregoirelayet.com;
	s=MBO0001; t=1791835075;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N5wVf6huEusiIDNk/5c7GdFjensv5aDGIBXaan7le38=;
	b=PF8ax70J4DdyyWDaVMYwj5BE9zGWp42Vu/wpb0TiSgmOPrO0MuzhosaYT7WyWPyJ9DKebB
	3bu6rYTuPlqXT7cBNYoP8GQf/lF5l1+r6gi0evdglP3kqA7RyKAXytMGtGdqj4z21Rsskd
	ryFxVMS3Ohw+HdfqHJ4jweB5DBklDOKt1f2nwZP4HwEk7+5VY/KmGHN9diO/P5xb4gs/tR
	AYlgjOD7NuvkvInPEdUtdqa5ikxa7ptY6CYyZ4osKwLC8bSqeuQfx9yn4P3O5JlHXrfLq1
	eo5rNPpmPXUcyDvjgIFSSfx+O/RQByINOzwoMXIaNbB3bPwL8qAGrrq+rPWXIg==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of git@gregoirelayet.com designates 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=git@gregoirelayet.com
Date: Mon, 12 Oct 2026 21:57:51 +0200 (CEST)
From: git@gregoirelayet.com
To: Tan Siewert <tan.siewert@9elements.com>, Phil Rosenthal <phil@phil.gs>,
	Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Corey Minyard <corey@minyard.net>,
	"openipmi-developer@lists.sourceforge.net"
 <openipmi-developer@lists.sourceforge.net>,
	Andy Shevchenko <andy@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Ryan Chen <ryan_chen@aspeedtech.com>,
	"linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
	Ninad Palsule <ninad@linux.ibm.com>, Andrew Lunn <andrew@lunn.ch>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
Message-ID: <1803265916.1474637.1791835071520@app.mailbox.org>
In-Reply-To: <e2e3d98b-9a89-4845-aa7d-0e23a1d95f70@9elements.com>
References: <20261008-aspeed-vuart-v1-1-d2be17c99cd7@phil.gs>
 <CAHp75VdiO9tPX2vLqsX2-omNvs-YjkWWD-HOiqyDSzpJrrZ_5w@mail.gmail.com>
 <60996F21-A12C-4FCC-9D5E-9D188A4ADBEA@phil.gs>
 <CAHp75VdmMwXRQFKLG8c4yAsVA5=eFZA3jagtMGb-qVswcQ88Wg@mail.gmail.com>
 <2F1931BE-F0F0-4F21-BED4-67080A40AEA9@phil.gs>
 <e2e3d98b-9a89-4845-aa7d-0e23a1d95f70@9elements.com>
Subject: Re: [PATCH] serial: 8250_pci: Add support for ASPEED BMC VUARTs
 over PCIe
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v8.52.252
X-Originating-Client: com.openexchange.ox.gui.dhtml
X-Rspamd-Queue-Id: 4j3Stq0Bq7zKncP

Hey !

> @Gr=C3=A9goire do you remember why `8250_aspeed_vuart` sets the PCIe clas=
s=20
> code to `0xff000000`?

The ASPEED chip can expose multiple things over the PCI bus (VUART, KCS, ma=
ilbox and shared memory). From my research, there is no such thing in the P=
CI specification for MFD PCIe class, or a way to specify multiple classes.

Also, assigning a PCI class as UART or IPMI KCS would cause some drivers to=
 probe it automatically, binding the resource.

Even then, UART and IPMI KCS drivers assume specific offsets for the data p=
aths which are incompatible with the ones from ASPEED.


Setting it to Unassigned class 0xFF seems to be a good fit.=20


I hope this clears things out.

Regards,
Gr=C3=A9goire
