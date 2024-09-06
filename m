Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39BAA157484;
	Fri,  6 Sep 2024 09:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725613427; cv=none; b=VrQk6yJMRxSPobOLjCIn+vUm88vf0Kg5rYjPN7RDymDIkm7SCPIvv0PCwG9AJ30uD10N1VamNVmpTijgrKAaK1BdaSLd6EzHt7TMpmwiy/7VVGn6nPA98dXPyW2SESt20rSqVg2zY+LNAMV+h0O+A06QwnWKYMnZaV4OMbvw2Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725613427; c=relaxed/simple;
	bh=HeY0vZrYVpAMNhd3txyn5kXm7PQgr5qxtPmD+s0Gt4g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sX4+8q7tiknJcENzXhtE3oKF+GF3bSZ3fiPf+YG5i1H0g+9F6j+GAdFugzfW9jdy1r4XfaemDp05Py+kbPKdMoR4I46tPQ36BAIEvh5ooi4asD0N9nqbxl9x1JWy+xjF07tk5lLL3zT0dAyv5xx6mtS9G92tB72Yu6eFCBuq4Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=klquHuVI; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="klquHuVI"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7c691c8f8dcso1249458a12.1;
        Fri, 06 Sep 2024 02:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725613425; x=1726218225; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v0dPgTNsL4xVhbmjJwsw26FruPkmctG8WEw3T6v40uI=;
        b=klquHuVIyEE/ALLzVb9DS8AuVWFQIreLoGmGQpj2OEVVgipIrT5LSAz3CAPoe8U0Jx
         cFGKpM25SulKKFzKhmXqis0C733rzsxU+FxlUetOzZ/JwSrMENU4ol5jHYLO8rnh/bBj
         2wuLgTaVkJzqQNCEuCg+HCb84x6yrNn1XmDOsuOD1vN9zNXPmyJ03FR/rvGF+mFa9Glu
         jqwCXCluxDgfZaCMtlG3VtTndTVMk/CCGbDtnZeIdbIWgwi6tGCULmgP/aSoDHu1vCmg
         CqUV7t4G+6/d5lFv9saPPxtFbiGC7/kxWWwLNo8mcwHUsBm3bZG9UbcPNcdCU9YEE22Y
         qlOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725613425; x=1726218225;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v0dPgTNsL4xVhbmjJwsw26FruPkmctG8WEw3T6v40uI=;
        b=Xj67u71UkEdy3g58+bQ3P7n+qaA0PK+XWrnua2qCTltOxacp3CxPJmg+o1Etqcd68b
         vWi8KgIeJCYim/bbKAduXZcWbtM3Q/kKhJinUCs5qgVP97RpVPMvkWPnWF0Wd2ZuWJ7I
         kyJ84k2055XdFSChAaJ2WBr0BTEipJgZGiOtU0zKsnKyE4PXXk8DmfOdDcQaTY4sxWEe
         d59tzVmP32DmiyWY1TMyJ7aJ+MY9VC7ja6KU+SZ0myxEl6zV/BE3YltC3R3IKNqvUNXT
         MWHAbCXJCGUnGca5HTzy+gO8DgDQ506mwAlcO5HeY5g72xq6ThfBAsXXpvYcQhX8OLXk
         r9DQ==
X-Forwarded-Encrypted: i=1; AJvYcCUy9e7tzd67zRvaxlSxaH1F4RvRn1ERSKPRfVzDnY7thYjOhNx/FYZKv3u2NKtjwG6W3by7l7iACzu/XzGM@vger.kernel.org, AJvYcCV6dvGim78g50ysCE+bVpvByXbosX6o6jIszuo7OnjfQRgsJBhII+AbzZR2121PKN/bL0YC2Vn5IjcSiIc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaueJ98rE7sERer1Ic6Zh7IspwwqauVwQVNy/WngdydE2xO94L
	AwZAXlNkl0iDZxLTPRkgGESaE21vmQoSzbSf7QEv2bX0PgSJCFUR
X-Google-Smtp-Source: AGHT+IH3PGvaZoEB4Q4ZZHrcHQbQ5ScgTgBi8PlrJmpCMhaaXQ0Ort8b39db7Cc0LfkD5fsVQysXEg==
X-Received: by 2002:a17:90b:1c08:b0:2d3:da82:28e0 with SMTP id 98e67ed59e1d1-2dad4ef2197mr2148234a91.9.1725613425279;
        Fri, 06 Sep 2024 02:03:45 -0700 (PDT)
Received: from localhost.localdomain (111-240-109-89.dynamic-ip.hinet.net. [111.240.109.89])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dadc12a1d9sm1007420a91.54.2024.09.06.02.03.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 02:03:44 -0700 (PDT)
From: Min-Hua Chen <minhuadotchen@gmail.com>
To: michal.simek@amd.com
Cc: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	minhuadotchen@gmail.com
Subject: Re: [PATCH] serial: xilinx_uartps: make cdns_rs485_supported static
Date: Fri,  6 Sep 2024 17:03:21 +0800
Message-ID: <20240906090321.537-1-minhuadotchen@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <33cb57cd-200b-48a7-9028-3f6bf46b4dde@amd.com>
References: <33cb57cd-200b-48a7-9028-3f6bf46b4dde@amd.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Michal,

>This has been applied already as commit 68c5efd9dca ("serial: xilinx_uartps: 
>Make cdns_rs485_supported static").
>
>You can also see it here
>https://lore.kernel.org/r/20240819120107.3884973-1-ruanjinjie@huawei.com

Got it, thanks for letting me know

Min-Hua

>
>Thanks,
>Michal

