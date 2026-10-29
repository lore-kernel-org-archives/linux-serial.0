Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793298142;
	b=H9ZTWWBqvM0SIMA2Zw48c4McXFcbEDsz1+XvR/2BR2nsXQUuX5TVkIvhxdOpPaT6F4BZ
	 7mMqb053bhnikKlw0BMhL0lGtPMWwe311pfD+5xorDBcmv+PMlJhM+ir2rPCd4AP4UIxz
	 W0Isu7nVSa7sllDOLMWNPcWC/BsTOD9/6sfwsht8wT+dNSec0rZVB1kJTB8IxwSgHZSDm
	 ru5swtigHvDEGmNS8FSAXym9XWPN+afTp2Z88k2UtJYcxdNMsAz7zHFQHmhNNH9yEh9T2
	 jIPgMmNcxWzmvshwzCtB6Zwng1T35z5kPvdretSGqdWyDTjA/OVfamO9Q7C2TTIkulw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793298142;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=j0lfMVo3cPVAp5JDNDwKQqogdYL+QezhiKu+RrquQQQ=;
	b=CA5rs/iJzLBP9CYpwFFMLcCTAJJeedr1w8RorDsS11meOqSiECQgjtMPiZ9gzmRoN1Si
	 QYJH/YjzmZ+ty1SvYRwoLbibf0mKjDl7hDfXkzkBat5+ENTOcAXe6HjdTbQy1Sp6imDCA
	 BlTiWydqGkBWmKADkUC355TDhzxcu3KWXUhC6lEUhmSeFA7Lyl3rHqRlE+VGaDBsDbuHe
	 OmW09TnC1b0MF7QB9YhLNXSz2ve7g/JshqrnY3f4/L7de9oru7LPMQqKNd0je9UC55G3W
	 swLJK8sNh7mJLBF0Yjwy4ijduolf3B+tctaUxGulkhtypyhTTTjG1CgkisP7Lomv3Gg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=f7lsMgPq;
	arc=none smtp.remote-ip=209.85.222.50
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7CD606A31D
	for <linux-serial@vger.kernel.org>; Thu, 29 Oct 2026 18:22:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3D7CD606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=f7lsMgPq
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-9828fee1b4bso875964241.3
        for <linux-serial@vger.kernel.org>; Thu, 29 Oct 2026 11:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793298141; x=1793902941; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=j0lfMVo3cPVAp5JDNDwKQqogdYL+QezhiKu+RrquQQQ=;
        b=f7lsMgPqYoGXQVEXNwMQ6Se0zCFaTo4CiLFLZOkTxV5lrJrY14JP2c+QceQzTgb2xN
         1RopzC3NFFSqYeFMehsKj1mxByOw9CGw5Nos19+N5QFLf0Bt06/8q/hDlJbGt51Br+JY
         THG7oZp5RNfPmaX8d5WQyjkjncjyUE+TN/E0xpmkdnHgf3HW9x2+XMX+RGnPS+B83Z6V
         A395mbYQQS/adBoslcZWVvlRjzRW/ZTWH1FzQHgVOy9CBJbDebqkVfNpCOPmT6sHWqNs
         atNJRg7LwA1VoKT8ee1nFLpLVAr1uEJ90eY6YsxzwQCj7W8aKCrrZRM2qMIkgAmyGcWG
         0ShQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793298141; x=1793902941;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=j0lfMVo3cPVAp5JDNDwKQqogdYL+QezhiKu+RrquQQQ=;
        b=UmW6se/Aeg5+u0vcIUVLmkI8IAxcoU+MGHYkYPYBVsSKbcH8ovlEmQnyu9CMg+mz8A
         Dmb3Q2KnWC61LBeijgFWtiISGDzYQoCTaO80cFYxLUuwUvn3tcxCtFBRB9YG4qXwHCh2
         3ZJj5DW0ZquCADIxxWJAf3d4RQvvv8//Hkg0VjpGYxNx9co+Pgbrt+7A07w7O3LXaEL6
         ozcdlwoPLFvlpn+vcgPfMfcjIoLj4lD/+RsgYB/VI+ppAwWvH3pPJr6X9Ol8L0CtnZAy
         /DBaTYRemQEOcDLYbEp1aJdtcVih9evHmVhm9SOQ1OiGhEcNbGf3ByUMaLHRHcjW9HRk
         1BoQ==
X-Forwarded-Encrypted: i=1; AKwUvBwKo5W33B9+1JIiG7pa58rtTolsvWeixJymGL40nA1b4o4pD9U6iGDptDVBYJ6QuaW2yXISUUoSm1ppfGw=@vger.kernel.org
X-Gm-Message-State: AFq9FYLKKWIOmbdnp45nzoWBNWSufaubif02LlPeGgTKU8+NfzskIX5o
	l9ZlEyzLAWqyDVZObWmY+uOnGvIs6AmGr6O34qKUTFMSbqNT+veXqXau
X-Gm-Gg: AYBFou25CFITw9lfm2bPgafPOd3cLPSO7KCv7ipRzZLqssvfR4AQ7L3hiPYRYFVCVd7
	eSmz8xWDTaQdX33jKu9jds1kX7o9VLnxOVEx6sl1fBb9WXYc0UmRpu9R6tt1VLJ9lFO6mKP3hsn
	XcrJHlKZ5pjw1rygYvhBy+xDgGLT66ESYQ5bouCjjS0Uvfpw17MpuQ8W5LDqOr77HZ5O+gAxxBl
	CJn+MnhG73c9sATyksXnRtRXtjycfEk6WJJkQbQ77tst3CRV9Ut+kgbY94wlSF3c43128bXk9AE
	SovDxbnnqZMBWc9UoRYpVjVlX19D9tJDPGwb2xB+8Iu6n9QBqDhmFMRzLzJ7siMUQBqcc203UJw
	4QVZNkOINHHuJqfanME2v/oauIYFiUY3VTCk/EJHnh+F44OkjJONXBJ6pG9SICnfpwNe7O2EhIy
	R+0TQCTqPoWzFpWWz6BSFl9XzNsJA5sLcYoZXpVfkth1LU05gNCdYPJwe3DvG9rcJfThF0+FRlT
	eo7VeqW2n2qLGAFk5EEB7bZQS0JYC6gNPmvPS8yXc1EWMWfYLaJmb6Ro4glp9C8GVkFMUiiN4YX
	zX3ClzeeK9aiDW7KgpnmZ/29Mj84y0FdI2NbR2+4A8nWjX5acDJg90NWE5pwBP7QXXAkiTyuw93
	/I8HAL03yumH5CXFKU3jaNuL2W4E3vXBft97e
X-Received: by 2002:a05:6102:6058:b0:7cc:95ed:30c9 with SMTP id ada2fe7eead31-7d0726402e2mr64503137.29.1793298141176;
        Thu, 29 Oct 2026 11:22:21 -0700 (PDT)
Received: from MaquinaLab.. ([179.179.238.247])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-992452cf638sm590014241.1.2026.10.29.11.22.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 11:22:20 -0700 (PDT)
From: Vinicius Pedrosa <vinicius.eduardo.pedrosa@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: James Hilliard <james.hilliard1@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	ilpo.jarvinen@linux.intel.com,
	Raul E Rangel <rrangel@chromium.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] serial: 8250_dw: preserve BUSY-safe fractional divisor programming
Date: Thu, 29 Oct 2026 15:22:05 -0300
Message-ID: <20261029182205.3453032-1-vinicius.eduardo.pedrosa@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261027-submit-serial-8250-dw-divisor-v1-v4-1-41714a75e15a@gmail.com>
References: <20261027-submit-serial-8250-dw-divisor-v1-v4-1-41714a75e15a@gmail.com>
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

With James's BUSY-safe fix reviewed, would you still be interested in a
follow-up series moving the idle handling to callbacks in
dw8250_port_data, including the LPSS conversion?

I have the refactoring ready locally and tested it on an A733 board on
top of tty-next, but haven't rebased it on James's patch yet. I haven't
tested the LPSS part on hardware.

Thanks,
Vinicius
