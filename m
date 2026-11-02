Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793649332;
	b=O0QbcxlliLHJur6JAHbbrIkLF1VWAYd07sxf7uSLhy2+cgMEDP5JLcagUKDaJTgkrBAP
	 dmrQofz8HWNqsizpVf/JVVZWhCBKqJR311WO4EjhgBaH6T2WfeDghnZbqR/jLNqEt0Cdz
	 snPJJhOQU8WArYxf3LkGJ7X6oojd0WsXGPdePKePPHsls9FhQ2cRKmfOn3WfqO+AcT828
	 xu9bzexK9gsak2rXVW9Y1mrjb9BOvcR6UPFLE1H+Nf1yfKq8lNLExju8YUgu5ZuIIOOf7
	 fwVYzXKSFJFDlxTEi3V/CKWckYVn1fH8019xi12Csu/v42uv3VdZZs0923rfZ4lg6Uw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793649332;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=QlRh548rr3RZodybaeLisbTTWEcq7cqJLOra+2wCfg4=;
	b=RI3W/lcpR0Wrhq7t1JdSkUTs4wuPHak4JvHxJa1gmiBPDEaEBIVr2kspk6xpEgXqncNU
	 x/ce62SxSfc4j+x1CRWbVIqWw5jXtsnWMjpWoZqcSd0BgpoAw3bSEJU1Mzjz6JXPcAEpq
	 fRWeWhTp/eLAUHeYqDQjkUCnIXT5vAJqnuBZYc5G/ocbl7mXkgQtks9YrYl0S2nIxSvyR
	 qf32c/JZSlxnh8zDjcvxtOEygN0HUPQSzN2W1PLADtX59T4uEKcxT+v1Wz1SsMo2fq/8O
	 1Iwc3i/HL2m2lbWhs+YwbvIx3C2qUuB24SbH42mpIzJU0EOoJ0/e1ve2BJNsuN1fQDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0tI1YuB+;
	arc=none smtp.remote-ip=209.85.160.41
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D606082BF3
	for <linux-serial@vger.kernel.org>; Mon,  2 Nov 2026 19:55:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 53D606082BF3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0tI1YuB+
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-4a755bbe158so4827fac.0
        for <linux-serial@vger.kernel.org>; Mon, 02 Nov 2026 11:55:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793649331; x=1794254131; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QlRh548rr3RZodybaeLisbTTWEcq7cqJLOra+2wCfg4=;
        b=0tI1YuB+zs0KnuaGqYlU+SONfRwA1e6goPMu/fCLW9InZ7R8U01d6RPKRjSui9PEct
         b5JM1a7zKE7fCmN7epJ2Z054NrJO3TfJjvfHTupc2yRHmgMJyhBnISUYZRrOrnLaINWg
         hZrrofcF+AszR11YUdigxcATbtGBh6s54IMrG4amIUM0lfRtWG8CLTjuuSOntmPOcsf6
         bgFkFbCxikjF5KXRYdjkTQsQM+8NBZzeu/AMRpa0nAr5R9DIjZDUurxTGQNhT7/JyISC
         pgQjZX/AGDiBW77knu2gtoY62Rrlrm8pXQ5Ctd5nrMkFCW61KYG6Da2FoGtTWjC0Ptg9
         CmvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793649331; x=1794254131;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QlRh548rr3RZodybaeLisbTTWEcq7cqJLOra+2wCfg4=;
        b=XYZ953CMlRoj8M0sT1pvtFGdTzPSRAUdB80a3xlAVruoi71k16Xm5CAKcOvDZzJqGm
         aU5dxUgFSIH9zDl+QsygsLFRqNS846sZoiD9GisAC8BUs5WIr68OlPH3RwIjbjOb8s4B
         lXoxO/CMiekO7TxqI/l7/45s26dW10rk+vWLSYtW9X6c7fBbPTW2Fbj0CFm7OyCFkwcl
         NZVppYNFGFbin0OPsIuAchaTKct02hFffSEa6dLjp02s/lxrIgyTtAx2kROuM2gGJ97b
         JxgFzc2D4tr5oOcZrMD8lUeoFz1Ot3sf0myHxW378lVzE0Da6MbW2hvFjU2MKERoA8jV
         R47w==
X-Forwarded-Encrypted: i=1; AKwUvBxM+08ElNtnHDqDpLA0MPs2cPD4lxQE7PfqTG72BrSVkrI7Y+OSl5+WE0wPSc+dKrT+apN78UK4+X+fHZA=@vger.kernel.org
X-Gm-Message-State: AFq9FYLUNUnVrKAn7KG8HnSpCq/LI/M8Pt5ThhqohLALUrGaaB2EV5sS
	vjmKiCH7jQMFVVa1Vi1NbpoxzmpZixrqQF4WIWClnm1EeB6oCSOLEUIe
X-Gm-Gg: AYBFou0c0VCHzGXU9V0KTlfg+IRnooGvi52cRTFlwwAc33wuR8yQIUgTxT2OcOVJPY8
	c+FNFtqMbeVNE/UwtSJqzHHw1fMwDtnxhV3zrozVJICJJ+pI29H8Pjm80kihHcScsP7uJW93qIu
	fj+EkEimWkWhQmGLrl8jZgmSaM58V7rawxfckgsISBhpl1yq0Kfu41LspTvrlo74fvo/CXBEQQa
	Crb1Da+mk3RVf/jgxadPGOOI6rp/ve5Qld037nCeTq/MGlIU4fKA2qMsJvmpc3JgimYxRrkC4ZR
	65jEjipwT1jAc1sygyDyATa4G4NAHZZqu1ZEsDcuSE+H8Xs0ohAiVrXv0kAsCNTh0bCSDsLEcZB
	5wzZ3vAzgLooGkSUwYg9TiF9HcHir8nx892GIT1SiZTnpt1q4cZGdnZXYHpNDRcrRdOnALysriO
	2P9481wVa2FEN1AACGF6cznVbvlCuwlLqWmJ3s6cU0d1JgcRCRStgVGWahhZ8TXOwU9CDWX5ZYF
	srvvOFFmhPzqiWc1gHU1OyWuIgSq5P9y9vVTQtfeiN/gVukAD3cQc6n14ZOoGIMOWzHDh4sg0gM
	fOqle+R1tpBnRJKZ3BEKoxycDNcUKQ/khdwoThOxMZkhH+eJ07UwMO6qFvizWJIn1Z6sqAGUf0Y
	CXx10rOrOy4H50F2CIuLx1N4VVNdGQE/0k7vZzt5IUH64QVD4qtcq2ukKEkvQQCLy9Iw5auTz1Y
	+1BxrpGUP4k4/RwunJO1w1FJyeA0ZE0GVxVEcgdbPvPRC2rO+4qDM=
X-Received: by 2002:a05:6870:f150:b0:48f:e0f6:bd51 with SMTP id 586e51a60fabf-4a8e0ac1b8emr6815144fac.38.1793649331212;
        Mon, 02 Nov 2026 11:55:31 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a921353dcfsm7809249fac.0.2026.11.02.11.55.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 11:55:30 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 02 Nov 2026 12:55:21 -0700
Subject: [PATCH v6 6/8] dt-bindings: serial: snps-dw-apb-uart: add
 Allwinner A523
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-submit-h616-uart-fifo-v1-v6-6-25afcb346b0c@gmail.com>
References: <20261102-submit-h616-uart-fifo-v1-v6-0-25afcb346b0c@gmail.com>
In-Reply-To: <20261102-submit-h616-uart-fifo-v1-v6-0-25afcb346b0c@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, James Hilliard <james.hilliard1@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.2

The A523 UART integration has different FIFO depths across its controllers
and reports each controller's depth in the FIFO Clock Control register.
Its receive thresholds are fractions of that depth, and its optional
register layout differs from the generic DesignWare integration.

Add a compatible for this integration, also used by A527 and T527, with
snps,dw-apb-uart as a fallback.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
index fc1289073241..ea6ce99178e3 100644
--- a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
+++ b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
@@ -61,6 +61,7 @@ properties:
       - items:
           - enum:
               - allwinner,sun50i-h616-uart
+              - allwinner,sun55i-a523-uart
               - anlogic,dr1v90-uart
               - brcm,bcm11351-dw-apb-uart
               - brcm,bcm21664-dw-apb-uart

-- 
2.53.0

