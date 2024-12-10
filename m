Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4576123DE8D;
	Tue, 10 Dec 2024 10:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733827068; cv=none; b=CEr30BwBo1wYOzhaYPehH5EHQTbaMLWBk3brHmzCdqt/h5mpz6fcRvBBd26h8wBxWzWV2gX+9u0NZEG4dVOuez9CtWO2q4nbvp6iGZZ4GZRVehqiZHxZeUitaWGpmyItmxrDF07e1H4Ph6BrCa7/ZSr/7j8RkCKGEZrInadeFGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733827068; c=relaxed/simple;
	bh=s2gNrBnpaHs4PuvXcXL3HNFdMIVsXIYH+9x7UBV+JpM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YIQ6Q+tvxVb8FYc8+SqKhxdk0w5efMzvbJPEF5np9jimDpzaZ8sZXYxZag00RTycvVeHNDxYjDw7Z0UbJPibgrjArdsorWL7yR515cSMVo9x63dCRP/21l/LvzL8DsL4VkM7BTQRLVVXQlGiwEVsydxfLkqnihdto8av9CCHY3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=etWNSVYq; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="etWNSVYq"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5401be44b58so2330126e87.0;
        Tue, 10 Dec 2024 02:37:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733827063; x=1734431863; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s2gNrBnpaHs4PuvXcXL3HNFdMIVsXIYH+9x7UBV+JpM=;
        b=etWNSVYqnQDeWW2iC6KeB33CTncEYSPZ9UtkkOmmiZl1uTm/rA2Sk5SnyoXKlVHlSc
         EeuJLo2jqmZKQOboB1Hhkcp9BTwa3oeK7bS1msgsX900FbpSPl5jlXob8FSiiEopAj2p
         /vUe4Ek4hHJNDxlhSu3WD2LOFXes25PY0JSYxRMpCJHqSoHQ8Sjf83IUbKIzb/cI1PQp
         2LDv5H5HEWBy1RW8uo98xfv2ky9IWtKtEFrW+cOmdvIhjnVDnt01oVEL2AZeZTnivD7Y
         lr3FlEuw735N3ejEZVTEsDh3WRIeaW8qmckDLzoH2lYkJ00EUbt62+0YOGZ21svRWQNi
         mdMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733827063; x=1734431863;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s2gNrBnpaHs4PuvXcXL3HNFdMIVsXIYH+9x7UBV+JpM=;
        b=v9SAjzqDtglWtZqWf9ofWsRwh/KI0AGUXNyPzMdZQKxBbRZs5BMWeEHhuzkK7zkHAb
         koqeNufNY4ewOceo5qMNp6j22Bsz17/AbKCnzNtDsbHIC5pMEBI/hN92DOT3pDiL1HBr
         GBq2ojk4GEUY3nsRZ4WEaICVgG+bvjF1Obn6zQlsnKL1Bnnl/7Q4dyczsBa6pXeEELVX
         EhjzopnZGwLbEY29h6AT/hTwdKD76AIccFLlmDxkQLNp30xTFndnOPmEPxwO+lc56HMy
         Goy3uP8kBusK10grlugfQF50pdZKrFqCPsWaOjlrs6BhxMWbhk9ei267jD/IVzaxfVzK
         vi0Q==
X-Forwarded-Encrypted: i=1; AJvYcCX7fDLF6kCuly2cqUrStDSty63NJJPPnnF3yzEQGHniDJDgehAl6NBgnO/NazUpCPypBhPkVYjcjc5SjAA3@vger.kernel.org, AJvYcCXxSslCXoScKbX7VCB9GfS6nqQaoBpARUwtcyTlXhJY1wHQVffgdEcdRizkb4AtbML7PnO9B8ILaXixUFk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo32tNmTM5mwAYt9Ok4cyOJrhFfAQBhZWyLPlgzhKjJVmP+Nl8
	DpeCR3nMfq/9MNT3ayx2airkaly/Vhm+PzuAuykV/5mNuHR1z3MS6w7M7k11EKRxnTAPKn8nAtt
	fJxiisCVaNRBUVpvon+HOcGNJ/Qc=
X-Gm-Gg: ASbGncthnJBrhBNb0GN12iAxxHTPRStoNl5FBH02nuZAszoeVfDUY88cNC5GnRBH4+2
	bmRNRKatmAloOEf95rEcMq/Byjvg/rEKLnES1xCzuHBjeFzZHxu+v4wuerW1XvEuLrdk=
X-Google-Smtp-Source: AGHT+IGvfRLPmahm50nu+e2exxVcMFSqXgjT/S6Twd+XgTU6pdYj8SRjRoKw86zHc3Jp+T8FWnjKa+Y2nt08isFeJl4=
X-Received: by 2002:ac2:5227:0:b0:53e:362e:ed0 with SMTP id
 2adb3069b0e04-53e362e0f1emr5392719e87.44.1733827063169; Tue, 10 Dec 2024
 02:37:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241210034223.1493522-1-xiaolei.wang@windriver.com>
In-Reply-To: <20241210034223.1493522-1-xiaolei.wang@windriver.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 10 Dec 2024 07:37:31 -0300
Message-ID: <CAOMZO5AzNVd_xut2wBBHeyccFdC+1c4p50Uhzo=+BDbV=mEP2g@mail.gmail.com>
Subject: Re: [PATCH v2] serial: imx: Use uart_port_lock_irq() instead of uart_port_lock()
To: Xiaolei Wang <xiaolei.wang@windriver.com>
Cc: l.stach@pengutronix.de, gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, 
	esben@geanix.com, marex@denx.de, ilpo.jarvinen@linux.intel.com, 
	linux@rasmusvillemoes.dk, stefan.eichenberger@toradex.com, 
	l.sanfilippo@kunbus.com, cniedermaier@dh-electronics.com, rickaran@axis.com, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 10, 2024 at 12:43=E2=80=AFAM Xiaolei Wang
<xiaolei.wang@windriver.com> wrote:
>
> When executing 'ehco mem > /sys/power/state', the following

ehco --> echo

Reviewed-by: Fabio Estevam <festevam@gmail.com>
