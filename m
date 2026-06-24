Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F13B2DCC05
	for <linux-serial@vger.kernel.org>; Wed, 24 Jun 2026 12:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782305306; cv=pass; b=bwz5vVJ1vjqFQvVrH5a8oRCn4tKkkcN0K2gLsUrq3ZQSURJSSqbl7eL5vvV43iQMYbxFOElJ0hS2o6PXZ5HeIw9nJyLv+SkuwZtSrqs6hffboMnOt7fzR21LC+BVCItGX02YyAr8JPSy/41lz9LCUC9t1v5Ko0HId4rf2Aq4E0s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782305306; c=relaxed/simple;
	bh=e7crjkX7xxDZ9ZyGUXr6JqBDMyWiaXIEE/qm3XJmLi8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=skWKcbdnwhXkvwPAbzO8mUN2522iHYcJEmBf6lTjwiUfCFDKhzic+IGFQhJSZ8EmKDTtCbdqfD1sT8szlHbRtFTgx3WoBCSK474kjdJXURHD4i+W8RnUj8P0bFhvBFYKh2YR5DuU6Cm3wqM4Ui6j4GZheDzcmEeoiIejFMPZI9U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=Xn7nVI8K; arc=pass smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="Xn7nVI8K"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-4631679f204so1085013f8f.0
        for <linux-serial@vger.kernel.org>; Wed, 24 Jun 2026 05:48:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782305303; cv=none;
        d=google.com; s=arc-20240605;
        b=KOTi2Luh7sOoGzrzF93mrjbyWbRpxDiyV2QzLrTyFlkOyyfpZ27RSjh2rodAOGfSEZ
         oNcZje1rK1H2Sm4Eb8oLn0bZVcb0lZDzPulszv/oVHWtt/WZGj6bvnwuh1WDMVvHRljn
         7edCTf5dR/Ubb7R4FhKDKCsixV4umep9kbr8miA5/FIgKfrTQ2pNKQfmBrD5b7SnQ8Eh
         5pZ/bRjsIAAj66/HvBzqDOS6rFDTnXO70xCbrkrOgg//S2a43aZ5ANpxjmDcekEltkvY
         xVvEBtduQ+wDzFLmAuZSK+nFNy36ezFWw6XSJWnSMuKoNcHoK8e+59Ouz83Oykac7sv6
         MHfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=e7crjkX7xxDZ9ZyGUXr6JqBDMyWiaXIEE/qm3XJmLi8=;
        fh=JvimXeFPsOBGnzlCB5wsWCozTA7tFDxz+nPj+IdcoFs=;
        b=I6AVq/qOzNr9bI9C65q8xLylF3YxP2SVARNxUZxh8TQL6ad+rHDWgN2FimhT/9XzI6
         BLPFTyJ0YG35u8zei3Rfro4vs0PVkWpM+m/z2txBupty34Mh2XQFF4rsieWLxmj9E3L8
         cIgkH0sBPzeX/iglSwwhDpAuOWdYaQtUDPvRyAFuWZfrTY5tHx0VzVGihELILdesH8q8
         J+jDTyvOKsql2s2OKs79BJTtQQGarWixyelj/HNzpfqmTPdGTpU3/3qN9guUBA2YBRtR
         YTg8mNJfpwVrYziL73RzgB3zYBA/Vj1wdCQo6JWE1HpnFSSNo0iNPM3TLERueZAgEG7b
         uYaw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1782305303; x=1782910103; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e7crjkX7xxDZ9ZyGUXr6JqBDMyWiaXIEE/qm3XJmLi8=;
        b=Xn7nVI8K3anFLQa+LVH+GlTIy/G2oQWSm1DwdLGwT+wyjUu/rYlUNRI4n1PeiGA0kW
         aEIMlXnszyC9MMEujuEwkZufTTXYn38xjEyGwpLKHpZDirzGKD7WfSv3I4+AoS5PDo/5
         495sEMaQ+d1Z5wRBJbZJxWu8zSouO3QhGPxbkl2RbTbr8Hau6uTPOU4V8cHIzQROO4u4
         e1uumAg3+UPVYQokbAn4mq+hLtDISVN5rsD4rliqQEhuEYk+LApER84PvqHWe28JbvY4
         k935EnF2fy07yr52X1RFCOQ4/4zFYtm89MX12a6tM5YzJWc5Hy5RNupclIcs5Q5VHURi
         87/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782305303; x=1782910103;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=e7crjkX7xxDZ9ZyGUXr6JqBDMyWiaXIEE/qm3XJmLi8=;
        b=pVZRHoxKAc8Hjh4ltAsEJYuMBVide9X8pRHb5lEM2CnJ2TXQxZIzF05OkUEW/bK0lQ
         Acejv9G0YqCKnswlS5KFSmpap5LXNV5r7Pnp5rTYQpm+AT/0TPHQ2ecFitGEAuCGJa4s
         nDTOlVOmEdEnmBm3EdijctQu5ybxCBRg+9tqzw5dySpj7ca5JIZQmsKmwUs2HF6rYLjI
         gQEmpoBlgHAN6v+w/0ItzW5U9b1YNv4sB5aQ8IbkheG+91l7UwfWBD1+jWPMYcWZBLaP
         8Hh0uxz7dK+3a8ag19xPdZZ13K/AzBce6FWWJC97u12zlNlLo2H5Y9E6Q8sL3rzR2oP5
         6rEQ==
X-Forwarded-Encrypted: i=1; AHgh+RoZxkP0CWLN2q9mMVldpl5iytTKJV0NJP5FR0Jv2J6leHCJFBS0fDZccOa1Ji4uaXt2ouA7G0DFPkrdGDQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiQLHsNpBDMlOJ1rAqLMwdcpEtyNCsTuzobXSOkKHRuEnkWDFw
	y9XpCv/TcWmHwzWCvMrIMfuvl/Gl7zsLA6qooBasTH/PgLnufjuwYhrZELG6JoF1Q4USTMqHykj
	xcIJE1Sr2oqLgUSWSLpzvJNOWgF4Uu/mP0bTsfKtHLA==
X-Gm-Gg: AfdE7clw+jNTNY/81rnUriRjT+J1VIy2BqXjJ7JiWSwSMbPxQBJZuQ1UHCaTgUb1CGS
	lwE66Vz99j5tU2lPjZYI9SQJbtxo9gMH6LtHc+0+VsV/nB4QZXe9RG74c/oX2b8bUjWQPupHfJu
	cbZRQtYKer6cszp4FsSmApkmYdHJi65nOfPg4M3vAmGWc5DTvN9wcVPPLw+hYDGwurbaVoX0EzX
	u5ASJxO5NaFFUjFnDZjYrnwOkjOywD6XOiQ9KXbeLyjapngKZdvS/hudH2f0fQemOLOXLM1XS1l
	1FlbvTfo3wAznstqp98hJfIkMpKGj8VwlMxLDh9+ln+6CzCj/J0bHsoKvw==
X-Received: by 2002:a05:6000:2488:b0:464:c5be:37fe with SMTP id
 ffacd0b85a97d-46d04d45829mr417638f8f.15.1782305303554; Wed, 24 Jun 2026
 05:48:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1782224059.git.gregoire.layet@9elements.com>
 <80d983887dfdfc7e70a6db95f8cb95b7312f3044.1782224059.git.gregoire.layet@9elements.com>
 <20260624-realistic-spiked-parrot-db1d9c@quoll>
In-Reply-To: <20260624-realistic-spiked-parrot-db1d9c@quoll>
From: =?UTF-8?Q?Gr=C3=A9goire_Layet?= <gregoire.layet@9elements.com>
Date: Wed, 24 Jun 2026 14:48:11 +0200
X-Gm-Features: AVVi8CcfDxQiwuKN4se3SFXuUd_U7WotHtCQRVpspiQz6vxahSkFlSb2JfFBv40
Message-ID: <CAFi2wKaL8qiv_H2GQ05CaeBDQwGvHdjb+dqmjQrHHzWNK6qrtQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/7] dt-bindings: serial: 8250: aspeed: add compatible
 string for ast2600
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: joel@jms.id.au, andrew@codeconstruct.com.au, lkundrak@v3.sk, 
	devicetree@vger.kernel.org, gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, andrew@lunn.ch, 
	jacky_chou@aspeedtech.com, yh_chung@aspeedtech.com, ninad@linux.ibm.com, 
	anirudhsriniv@gmail.com, linux-serial@vger.kernel.org, 
	linux-aspeed@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Krzysztof,

> Do not attach (thread) your patchsets to some other threads (unrelated
> or older versions). This buries them deep in the mailbox and might
> interfere with applying entire sets. See also:
> https://elixir.bootlin.com/linux/v6.16-rc2/source/Documentation/process/s=
ubmitting-patches.rst#L830

Oh okay sorry I missed this information. Thank's for letting me know !

> This should be oneOf (by convention and actually more accurate meaning).

Acknowledged

> More important, where is documenting of the actual compatible?

Yes, you are right, I missed it. Will be added in v4.

Best regards,
Gr=C3=A9goire
