Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D9542668E
	for <linux-serial@vger.kernel.org>; Tue, 20 Jan 2026 19:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768938996; cv=none; b=f2tc810z2glQvBmc8rpEqwfDuDJJdXmNuIgRrPo3WuREyGGyZU2/MknLKumT2ibKkXMXmXp6E1HyG1FgMkO6UudF1WmNoCy+AsO5mCSxRCQs5auP/c3kf/2pKXi6bgmI7P+JWDucCpu3g5URPhl7M2c6GskvOJhMaD1Duw6J5i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768938996; c=relaxed/simple;
	bh=dpRYr3skIgV0rzJn+6D/Wwyl8T3WJJeqflIDq7vz970=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cNQvLhNHQDw9tp4hWYBmrmytqJGECmqu5BLMSPnsx2ieKuPwVXszYvDY3msOLTxaMHl+Dgjxlqx/tRax1nSco/oqnguw8uPYCabZh0PKiKgqv+4aT3lXDDq0xmKggP6ljkaDGE38Gxrb9DKgCLMq1bPY2pkZI4p4raknlQL8yww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ilTP+W8u; arc=none smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ilTP+W8u"
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-12332910300so9199761c88.0
        for <linux-serial@vger.kernel.org>; Tue, 20 Jan 2026 11:56:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768938993; x=1769543793; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lPDgUMFRl+w+AbB4KcmndfGR0As68bgylKNbbH3AGMk=;
        b=ilTP+W8u0C7h7XBeoah7AsJ9JL095ZDFwxa6je9YceSe5kL434AEa3e23rZIbJCd2e
         jnO4xLKmsw5RyE29tSBo1CYXW/XhUGjPEV8BMF3noJo9ZL8fHVkWA5vnGSaSQLiOet2G
         u33Z96XEok44vp/L8jcalhxIbLF2VdgdGVnEmHJyBf+WvA6eY40iDArMrDCHTCvuYbGV
         R2IRMW4ie8d0lDUcYo3zWHSLjXKq85+4R/INtdkQm9SrWFC2O2lwXCSL+pV6WY7K/Y4J
         v/prpxeGXBy2mhWGLzQMm/WfVUt37+/etLvLAhGEDEyKKhHhl6i31LdTJJSmRTJrCn8K
         b7Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768938993; x=1769543793;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lPDgUMFRl+w+AbB4KcmndfGR0As68bgylKNbbH3AGMk=;
        b=AtAV+iIseo6X1vaq0PHhpJXfO0a/7SWVgVLg1vxTCFzIu9SxmDRAUsxqIMLjJg1/2V
         LK3dw7FlI2cmwCu4gPo34AO7rJoCj8rxkq/+7YDkJxx7OzTcaGoDz01q4s6E2hyaJzVy
         sISEVhjjeTDL5fnYZgMKH2sMXejl3IwWWP+xvDJWh8EH6IvkB+a7vQgKIqA1pqG7Qr+8
         irwbKcu5DcAcsoT9GQADMb1nsx8PMhwDy84u0S7SCkmSAVDQDenKhIZf44XHVGfx379d
         6xmhBlZ37RgTy2QJbEHyiFq4GWLn5Ex3ldv/a9chPJr6nyv63FE9I+noFxQBCn8csNRk
         +xig==
X-Forwarded-Encrypted: i=1; AJvYcCXBnOMXocYwUvCPNFXcy8m7S9wn+47UHbDb9tyymGtjmf060RHZ9xE6GZd190GTNLdr7WCTYzJTQtKjCuU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOhyT/Zbl5lrlhGp/8/ePdoSiwHiJM1KpzJBgiONYKDpd2mskt
	VzIbRDE58Q2jhuWE16yGq2ASF1E3BqEY0wAe7yLdwkQ90ObG7HpUdKMk
X-Gm-Gg: AY/fxX4wGLkR7abnHiGySyeY14hFgvvNIT/7KLtkBGVaoFtam8tZ7xaxYRnB0P401v6
	Aor2IL73W68VZlI9/NER6pFUXSeTchqMGbPLFXMFi8922eF0atgL3b22NoTFFiGAFB7rKd80I50
	u4pom/TQEZDP0XpQjJxdTEUIgqRMPwgAD6cxzwaF4GMrhbsDDgAGuM1Isx9a17QkPeYnl+FcLEa
	OMe0ecQa7HHTjerk2o11a3cGoYTnVolIOAZeOhCepcoVy5dihi6ZJkaFLEOhYE6JVPRuKTvViWp
	S4lRYIPR6BydOdfa7dBcBxSrgnssYhIAuYUMEIMVaf5RpTWkkv9oIwY55xB8qJkNQdeqjGRHQDQ
	UbgQb3FSDbdee1M4FR+p+9oNXdEeDi9JfUNszTM+WHxzaxQubyGiCIgKN+hFgf8JRAUfdd6RWFo
	2R7IVWClOHGiyy5U4qxR6mziXMoi9rYnomVjZL+lK9wNep/yTwg+/U
X-Received: by 2002:a05:7022:608b:b0:11e:3e9:3e8a with SMTP id a92af1059eb24-1244a7910d8mr14869120c88.49.1768938993269;
        Tue, 20 Jan 2026 11:56:33 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:d631:e554:f0bd:4106])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1244ad740c5sm23388705c88.8.2026.01.20.11.56.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 11:56:32 -0800 (PST)
Date: Tue, 20 Jan 2026 11:56:29 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: airlied@gmail.com, simona@ffwll.ch, maarten.lankhorst@linux.intel.com, 
	mripard@kernel.org, tzimmermann@suse.de, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, sre@kernel.org, gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	lgirdwood@gmail.com, broonie@kernel.org, jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-pm@vger.kernel.org, linux-serial@vger.kernel.org, 
	linux-sound@vger.kernel.org
Subject: Re: [PATCH v4 3/6] dt-bindings: input:
 google,goldfish-events-keypad: Convert to DT schema
Message-ID: <nab4yksjgk7jbofm5fkrafuz5c3dmi2oocdzgoscfj6ua7zwfh@olnrxt7sa3qp>
References: <20260113092602.3197681-1-visitorckw@gmail.com>
 <20260113092602.3197681-4-visitorckw@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260113092602.3197681-4-visitorckw@gmail.com>

On Tue, Jan 13, 2026 at 09:25:59AM +0000, Kuan-Wei Chiu wrote:
> Convert the Android Goldfish Events Keypad binding to DT schema format.
> Move the file to the input directory to match the subsystem.
> Update the example node name to 'keypad' to comply with generic node
> naming standards.
> 
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>

Applied, thank you.

-- 
Dmitry
