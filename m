Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D7A22EE5;
	Thu, 12 Sep 2024 03:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726110437; cv=none; b=go3x1slxcSk0DYYr+YNMGaUoSfpHbt/225um3cdcpsAnG9Ckb5twRzWMLehfesBZyM4VJ2JtUxT27n5oZJCZsAP36x0qTEA9ZrAT62H2sEGt6FYXfN3eIgOxgFAjEgQSok14eJ/gVSUbYBNyipOgsmJ1ehcQORPG14jYLQQkvvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726110437; c=relaxed/simple;
	bh=S4ecD8RIBfWL9S4Sp6s2IFF7W8ILz/17QwDN3NU8wmw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Nz5Xb5hjnEPEgrsk/CL8COs+rdCM85IW1o8Vzj1wfVD+Cl2lWplXqRk/6mTO9izCMOVmgH0na3vS5LavFvA5nz7KDuuLnmTGGJj0pyAfsz+BVAh19zUO2KF+uNrnd74Re4SnlrODaoxSAcCBncnAYR6ilBIGjhEIklfDNNrfGqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=gfoHxatK; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="gfoHxatK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1726110433;
	bh=S4ecD8RIBfWL9S4Sp6s2IFF7W8ILz/17QwDN3NU8wmw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=gfoHxatKP87BUArUp2ptHZ5GZpN6lZiW7GpYxpM0Lh1ejtUTP9JzrH8oB+Now2Css
	 IqVuIAhg0wKo+QBAftZLGxHMKoa2J+ZYdf5jf7Gc65R4cB15c/3NltCXRLIaLvFIVG
	 RzU+xvIwIAar1ufRW/Gh+N0IKZBVb3DchdMc4ggycoxnVVmXNcU++tR/ZJzPu22ZHg
	 0lxN7lQDxeWKD1OAt3Kyya0ypcs5QK25+/gWMJrP+PHuENuc4uHnROeXfwemaQzh2H
	 jLhtHBIV3SU4GhQpj3RawTdK9+oLvmENtKuUvfKwRgWdGkAYAnH+rJbQhPvLK23k7a
	 dKVW3UOj87oNA==
Received: from [192.168.68.112] (ppp118-210-89-8.adl-adc-lon-bras32.tpg.internode.on.net [118.210.89.8])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 6F44B650D6;
	Thu, 12 Sep 2024 11:07:11 +0800 (AWST)
Message-ID: <3a5fb92a32cd1d23029dce8a87297175858bf0c0.camel@codeconstruct.com.au>
Subject: Re: [PATCH -next] serial: 8250_aspeed_vuart: Enable module
 autoloading
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Liao Chen <liaochen4@huawei.com>, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, joel@jms.id.au, 
	andi.shyti@linux.intel.com, andriy.shevchenko@linux.intel.com, 
	u.kleine-koenig@pengutronix.de, florian.fainelli@broadcom.com, 
	tglx@linutronix.de
Date: Thu, 12 Sep 2024 12:37:10 +0930
In-Reply-To: <20240903131503.961178-1-liaochen4@huawei.com>
References: <20240903131503.961178-1-liaochen4@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-09-03 at 13:15 +0000, Liao Chen wrote:
> Add MODULE_DEVICE_TABLE(), so modules could be properly autoloaded based
> on the alias from of_device_id table.
>=20
> Signed-off-by: Liao Chen <liaochen4@huawei.com>

Acked-by: Andrew Jeffery <andrew@codeconstruct.com.au>

