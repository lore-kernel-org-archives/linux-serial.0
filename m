Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764F3218EBA
	for <linux-serial@vger.kernel.org>; Wed, 19 Aug 2026 14:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787148171; cv=none; b=JwIHafX+fLH1NPop5SadKG0FIA8IPEvKHJNpy/qhkVoSyfE6jUzh5HCyXZkTctJV+MNgkDEmhxxIGgZPsZR6naZvHANuJJkmtI+hg0I6L0k4KWhPHFP1ALxJldabQatHQ1QKLG+tmuu/c0c3sU/jMmERuFgSfiYGzAB+3TafyqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787148171; c=relaxed/simple;
	bh=dlXJOH7EU0a51dAApmdxSA9IP84RNY0Lan2Iu+swRps=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=KDKfy47WBGr0EamtoJAoNbyuy59uxLjMAi9VpvvJMJLucSVzVeQarp8XHIfxTGdmfv3qJC9+EX4Pquudgh8Dy93aTDay8r8UohksW9QAPgiOTzH+BEbEaieMtza8Fyb6H77nuxeY5J8egkJUt6trVAZUggMPb8RHJ1mRcQ2LIA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=I+/PiMJQ; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="I+/PiMJQ"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-498028b3d5eso12172215e9.1
        for <linux-serial@vger.kernel.org>; Wed, 19 Aug 2026 07:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1787148168; x=1787752968; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=6HUNEom2bL9x12H58ozzx5ab5h2GR4Ct4g1sEt5gJ2k=;
        b=I+/PiMJQJv0XawfDuNp57y9GkpvVNTMB8xLKF4+LKK8FtXU9E9KcKa5ObGN5gXi9O8
         mqjnEBtgsLPVludn0DA7UOpO0Xe/xu1a0P6otNZvXocnDW1dIJXtQzQbXEzNUx6+WuaC
         eT86qngvLPshW7Vh0H3ULeGheFXTuVP+iXQ3lffYfwRkJZ4KTacL+sC6vZSxZeYFJtaS
         oDTYuIIUMn6QVGw2DJczLwIBfW76N7jhYCsOwI9+HiYXN95lPpZOCMu3Hzou1RqHYyjL
         7FcaVwnG5qt+JtA+7Uipc5XzMSnkkjfMk2kyyo5a400eu6ceNWoZzlcByLP5khku8Zd3
         0kwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787148168; x=1787752968;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6HUNEom2bL9x12H58ozzx5ab5h2GR4Ct4g1sEt5gJ2k=;
        b=leRsTVWMfPRunHtDJdEsYXxIgnYPKiJQyRaDa3h68oCBFTHArum8QytywKl+nQAP8+
         yoHbAO8805R16ohXA1e128Js/nud+W6yUO9IJWxuoi91KeZeLk5KApf6Fk4TX3vPymYg
         Sly4MsldTgtW5XkSSt9SG/eFlm1D8VK83CDvTS7l43ea5JjQgwY+lzs5m49pCNkl4ARA
         OlhRd8HA36KaJCnWIFjI9lFyLwxSQ57nW5LHYSo79mhPAntw1KNJ4qINnZwjPV0FGmNW
         Tyg/7KROJ3yQQlZikcz/xZiOQZXHcGIdraYjCLkNSZ2sEkY+eiDVNbID23idBhi+ztrK
         eN4g==
X-Forwarded-Encrypted: i=1; AHgh+RrMkARtWYdFwcYRqkY5lKs1QXEcizGpiLkpuuhOCXObFYEwiwdPoadZSj7kUSi8vA69/gW/hwB7PEGLrsc=@vger.kernel.org
X-Gm-Message-State: AOJu0YziIdDktT93bxXNWLHc5i4cqp3zne67aobldW7OrpG3n+0dItfL
	8bJt4OvavCjwne4fuFmb20gwXgGSNfnfvr5A6FeFnxhO4x+qYsektYicb/DrW1mfow0=
X-Gm-Gg: AR+sD109ElOIRtCHZapQSRCXizueRmolpwtzF2ueXXalnhdzkB2RusVLNjtx04mFrH6
	h2m1Km9IIOIzd20BX8vpwMfZ1Vl4KjVMCQLfnWtUt1kYSXjVa8UKEtg05zQR8meD3ncFk9nGO6p
	I5YEgY+j3yPv5IA+vtwf5fMvxjeV6LGQ6XLSpHHiNNNOxKbbzBJuWKV1APh/pdnx3PS8NCkgs5n
	QWv8SWSbh8GmlSgIkPDEc9pGDzPEAFkOgd1MUvyS4Dcf/YWGXroMJhJ7GqeVONR0Y9saq/aErrb
	eRo/6O8ANah4q6KfXoIKTmqo/nEWpEtUOn0RhJwoIbgkXLPJ5G6xcVQr+7jkiBFAWBpPFOf5ZO0
	tFMHSQwwg8USRc5766mdjye3IIQY+tut99bG2p9hJ5yEAM4A6lemrv1/RR2Ces7CpyWP9NKIlu7
	y9GlxkcAJKWkBb/7/gNE64zOVx2AhP7AboX+B+Abo39eyFWzDM4e/RinhB/kQn4M41/5NOj6THE
	cs2sgE=
X-Received: by 2002:a05:600c:4eca:b0:496:c1f3:e8f8 with SMTP id 5b1f17b1804b1-499aa1a7a53mr77553585e9.7.1787148167637;
        Wed, 19 Aug 2026 07:02:47 -0700 (PDT)
Received: from [10.0.5.39] ([2a01:599:445:d261:4474:9672:b73d:5481])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499aa1111a7sm65896975e9.6.2026.08.19.07.02.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 07:02:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v6 6/6] ARM: dts: aspeed: g6: add aspeed,vuart-over-pci
 prop to vuart3 and 4
From: Tan Siewert <tan.siewert@9elements.com>
To: =?utf-8?q?Gr=C3=A9goire_Layet?= <gregoire.layet@9elements.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lubomir Rintel <lkundrak@v3.sk>, 
 devicetree@vger.kernel.org, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Lee Jones <lee@kernel.org>, 
 =?utf-8?q?Gr=C3=A9goire_Layet?= <git@gregoirelayet.com>, 
 Tan Siewert <tan.siewert@9elements.com>, linux-kernel@vger.kernel.org, 
 linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, mfd@lists.linux.dev, andrew@lunn.ch, 
 jacky_chou@aspeedtech.com, yh_chung@aspeedtech.com, ninad@linux.ibm.com, 
 anirudhsriniv@gmail.com
In-Reply-To: <20260818-aspeed-driver-v6-v6-6-fd7cc0b338ea@9elements.com>
References: <20260818-aspeed-driver-v6-v6-0-fd7cc0b338ea@9elements.com>
 <20260818-aspeed-driver-v6-v6-6-fd7cc0b338ea@9elements.com>
Date: Wed, 19 Aug 2026 16:02:33 +0200
Message-Id: <178714815309.32179.8598674853319251320.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787148161; l=396;
 i=tan.siewert@9elements.com; s=20260527; h=from:subject:message-id;
 bh=dlXJOH7EU0a51dAApmdxSA9IP84RNY0Lan2Iu+swRps=;
 b=c/KerOBtBLlU7G268kqzunbiL/W9hE013JTk3ATgEU/VaHaT/LXB+PpH0Ob3QlfkpPx+mFF/z
 EYquBWAhiQTBMj721ke3wRMepR8gy9yQ4WznJiFfSG2PvjnXP2qnlLi
X-Developer-Key: i=tan.siewert@9elements.com; a=ed25519;
 pk=ORQd/zQf+LsAvJGXP1CjQwVO6t6iEOGq/eGUsmRVTG4=

Hi,

On 8/18/26 12:29 PM, Grégoire Layet wrote:
> The VUART 3 and 4 are VUART over PCI.
> Set this flag to indicate this information.
> Also set the scu-syscon phandle.
> 
> Added lines are compliant with dt-style strict mode

nit: no need to add this explanation about dt-style strict mode.

Other than that, changes are fine.

Tan

-- 
Tan Siewert <tan.siewert@9elements.com>
