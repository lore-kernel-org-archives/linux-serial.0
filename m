Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792576878;
	b=HRQWiE4P6jyWj1osMsu8Hp2mOg5KcO5fSuo/NQMgrYlq5L2aXEZWob7Vh1MdZop9IoBo
	 JyuPW+mRCCDPuh3OCnsP0AH4UGBtrFxgSsdP3z+tKccUsypsHZlY/JoyMAjxTq4iBzeF6
	 jPdf1nxeSkOIiPcYRxZaSJ9X0U3quPP6lGeogOGguD5Ily/FMOhPmgey3odrLUp5Rj6L7
	 mZn7yR8Wnv1IhtTul3tuH3lrxHYdIDueUm9WmTi5OLJbqjFfoagAgAp23tDvpt8mUV9rE
	 0pYG3ah7/HnSOCzYlmcHjJEUuLa2iSYhX+2NWza6rJq18+vWz+MbIKWt5viUZSkNdNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792576878;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=RVJTwN159znt8hJRBq+zKCr4Hg7h2qirYM0EqJu+lc4=;
	b=pg+VIUfVT6YQnMbpfiLO7Jh/QUNDNNUElw3EDYDlGA0NnnMWV7gCk/TiccYl/9oSjjq1
	 aw0ENIrNckDofjVxpS8vDsVD0m2e7s2UbhnLtDUB83aR6qJ0ehhjsCjsb74KlFlhsu+jF
	 MSe3gRARE94nBA+8ctQAmMAcUCb9SaU8WGc8IRREpnk1cR+WZEEw64ysCW6n7275l5SdJ
	 tbT3NnazrvScz1cevTgseADVc/koITCoivatF8/99d871vCkCv6TkmWMe294dSocYCEar
	 dBD2AT1NSi8dWsrgyzWObXBzjLfY+Ll57V8ak5orw8p29qxRmDGD+7Lt1uRn9PCJnYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Md4AJRPq;
	arc=none smtp.remote-ip=209.85.222.47
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54866606A31D
	for <linux-serial@vger.kernel.org>; Wed, 21 Oct 2026 10:01:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 54866606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Md4AJRPq
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-99061e2171cso163543241.2
        for <linux-serial@vger.kernel.org>; Wed, 21 Oct 2026 03:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792576877; x=1793181677; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RVJTwN159znt8hJRBq+zKCr4Hg7h2qirYM0EqJu+lc4=;
        b=Md4AJRPqTd6XcyhcJr0pjgBw3QByVzkZMaaXLEPVkqMKkphH/Oj9O3NJ63bJBVmpo/
         qJRSZEaID43R45Hdf4XmuYpAMYDJyyHWnspl0iDU2+gmgsn2rDOrjfwpMTYXt35dyxsO
         nxhdY7dWusvN7DYJS31pRMSVD/wdEY9PooJyKK3mbgniTD+liPMz7cIqZfrWRZKKVXoP
         9yl1oKHb5UCCJP7oNistdgdGWN3RQrmEE8HCVHJILFjwBn+1rrTSBX1haazi8cPI0VaF
         M43WpJVIYk1LHGfTUFBWuxEHtB9U9CUyq4OYukx31lPRUYLTu7qv4n6TF4qpN5rLmiG9
         //IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792576877; x=1793181677;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RVJTwN159znt8hJRBq+zKCr4Hg7h2qirYM0EqJu+lc4=;
        b=DWXpJjbZaB0hxM9eIrWpFv4n7F2CbZ7ZdWWtUz74qfdaEnD2TM+lOHdiyj4X7udwuS
         ZGEB89kksjsKL5KhqhQ1dBay4wP3tDHRe9Vi1CR0vi0CgfXKNfSN+pHM/PMnPRMOx/TO
         thh6wRUdlMw+aQGJvV3O6A7NwWtzx5oKczUhKsGu8BSeCLwlUxzGd7o9US2j4XUB6cjJ
         VeyjBXpFLOaqxaEWrEwup0QC8lAGk9KEbTVx5t+Z65Qr3xCx88bNggcf2ONZj9TzKCJX
         brKVhU6vLWazcnf/k30uaDOlkxXBpeBENE1YDOYOJ9vvu//4uJifaRtrD6D/hT1PpI12
         vtrA==
X-Gm-Message-State: AFq9FYIspCx4fjHz9pYMxZnk1A4hclSHK9Z7MWl3ZaTT66r25KLr1vhN
	0yMVL0zb2YDoI4eHcc7T8q8TuNIpH22u2uK5ZG6CwpJ1BFcQO7fWja5h
X-Gm-Gg: AYBFou1possQslXbfrbgI3/KXt+8FWF7uvs0ipy1qP5FWHzu4NYFFsrIXHqd6gzh2Ky
	vshwXaIW0rOQgtwgAokEYHa6RlW7TXUmVUybbN9mUu8IbxXVX22idRIrDqpgYdXL9EWR89z6FCV
	/U8H0dBqwpXbUK90fCWELpTJstG9PBE84H33ZbHIDUZBywi718FoQn5qtGjSaAm4kFvdgaodT0/
	VZtgV+HOVrjX7TIrnrSGy03K87uefPxWrNQxhQyA2f700azBQZiq3CJnKwVwo6LoJOs3eXs3YTT
	9z+dDW1mImGQg/z/SVz9mBKUWfiXyANP4lGomzeJ72yjzhDjSwApm1ITjbuML5rTnjThtOrntm9
	jFg1g5a5US5ZD9vRA7tBUNeF8Pk+Gl5VmYmqYGiyJQCJFoUZj7DFlz4IaU2sBER6xZ8uPSEikjE
	zf1vhBa9bHkjGPzCJpzhVG4U6RDtcifC0thRRvPw+VuSkOFUAd3aFC8FLVMd2lUtRRattwtzcgk
	FgokWu+qHI5YJF/dl3fqRIFYa6l/LTgK32KRejFeXxJuaGWtbNbJpMdv1C9n/zKHT2KNlwprSSP
	vkQCbKlVXlvGglmkGDWWAkeA1Gl4LUlqmCYk/nHQtlMD+hb3FYsbHUa30RyPZ3o=
X-Received: by 2002:a05:6102:4187:b0:7cc:776:6c41 with SMTP id ada2fe7eead31-7cc9273dca8mr461720137.22.1792576872539;
        Wed, 21 Oct 2026 03:01:12 -0700 (PDT)
Received: from MaquinaLab.. ([179.179.238.247])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-990d118d522sm2526812241.10.2026.10.21.03.01.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 03:01:11 -0700 (PDT)
From: Vinicius Pedrosa <vinicius.eduardo.pedrosa@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-serial@vger.kernel.org,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-sunxi@lists.linux.dev,
	Andre Przywara <andre.przywara@arm.com>,
	Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Enzo Adriano <enzo.adriano.code@gmail.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 1/4] serial: 8250_dw: Keep the BUSY-safe divisor hook when DLF is present
Date: Wed, 21 Oct 2026 07:00:49 -0300
Message-ID: <20261021100049.16504-1-vinicius.eduardo.pedrosa@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <athe0QikG2mzCAtd@ashevche-desk.local>
References: <cover.1792439398.git.vinicius.eduardo.pedrosa@gmail.com> <cc358c2be6b0b4ea0323e4f694a581ffb667112d.1792439398.git.vinicius.eduardo.pedrosa@gmail.com> <20261020104753.28703-1-vinicius.eduardo.pedrosa@gmail.com> <athe0QikG2mzCAtd@ashevche-desk.local>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Andy,

On Wed, 21 Oct 2026, Andy Shevchenko wrote:

> Right, but have you read my second question in the above paragraph?

Sorry, I missed the second part of your question.

If I understand you correctly, since 8250_dw.c already has the BUSY-safe
set_divisor, you're suggesting that it should have the matching
get_divisor as well, instead of pairing it with the dwlib getter.

The dwlib getter would stay for the other users of dw8250_setup_port(),
like 8250_lpss. Is that the structure you had in mind?

Thanks,
Vinicius
