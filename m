Received: from mail.commetrax.com (mail.commetrax.com [141.95.18.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A5230DED9
	for <linux-serial@vger.kernel.org>; Tue, 14 Oct 2025 08:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.95.18.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760428881; cv=none; b=ku3uVV2wmUuUh9BcsDohW1Me347OgmGELhUaVAbBbNCvzFbHGE2lWRdXGrC7XpaiCMaqVWORnoszCVOgp/LnJc4fTAa6DWbLVg6843HDCAZgw+Tx5cZzL+CjlcPSogeMjfousX0WopKipUmnkPE53ARR8F+k8r47EhSa2wX8TQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760428881; c=relaxed/simple;
	bh=M2z+nFeXqIRcbI6rcgrOtIQjqLLid9ZQ1XheJsIeFLM=;
	h=Message-ID:Date:From:To:Subject:MIME-Version:Content-Type; b=kRQURwn7QrG5WLRRIBoA32y4+JYJGGmbRPPAGD2v3pGZXT5vWAU8/GExVFQrgZ/a4UOtgvOjfIgsS15UVkrMHja9knsqLXciE2+PpV9NLYmzYYzIsoh0C7Tl36a/1nyzbUCVdLRv/hrZoALMwkMtlO9s/zs1mLdLgApQ2Gu0btM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=commetrax.com; spf=pass smtp.mailfrom=commetrax.com; dkim=pass (2048-bit key) header.d=commetrax.com header.i=@commetrax.com header.b=CH1kgUhF; arc=none smtp.client-ip=141.95.18.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=commetrax.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=commetrax.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=commetrax.com header.i=@commetrax.com header.b="CH1kgUhF"
Received: by mail.commetrax.com (Postfix, from userid 1002)
	id 20CAD240FD; Tue, 14 Oct 2025 10:01:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=commetrax.com;
	s=mail; t=1760428878;
	bh=M2z+nFeXqIRcbI6rcgrOtIQjqLLid9ZQ1XheJsIeFLM=;
	h=Date:From:To:Subject:From;
	b=CH1kgUhFkkpSQNlr3WHGM8rFexl7j2IXslgiskCNEM7PgYJsmwLtrea2hMGpRTsvr
	 SuCkelai17+jcoYlSco+2UxANCkYo425ZJBdo+sn895DLNm10Vmt9TB5HcZcGlOLC6
	 JswCO/sgOiBgVkmrQ7DjGKUd4NuU68DKKqQBO2LUi5aZDTwPG5oOczC9dSf2THoLFq
	 Wouni8fRJQjZ51PmM0ixST6ie3jqUisaGVG0iTudB9pKaphrLbAiK0HxCaVDtVL7af
	 EUb4dFoKsj4/Xp5ev38d+Q1W5ItIsQWmCOg9Kcl5f8skyMUqzWbrjHD0KmXUTvd7r+
	 kYXcmL8qHsejA==
Received: by mail.commetrax.com for <linux-serial@vger.kernel.org>; Tue, 14 Oct 2025 08:01:13 GMT
Message-ID: <20251014084500-0.1.c9.16nwp.0.gm9f55m1ep@commetrax.com>
Date: Tue, 14 Oct 2025 08:01:13 GMT
From: "Luke Walsh" <luke.walsh@commetrax.com>
To: <linux-serial@vger.kernel.org>
Subject: Welders ready to work
X-Mailer: mail.commetrax.com
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

we support companies in carrying out industrial projects by providing wel=
ding and assembly of steel structures =E2=80=93 both on-site and in-house=
=2E

In practice, this means we enter with a ready team of welders and fitters=
, take responsibility for preparing the components, their installation an=
d quality control.=20

The client receives a complete, safe and timely delivered structure.

If you have projects that require steel solutions, we would be happy to t=
alk about how we can take over this part of the work and relieve your tea=
m.

Would you be open to a short conversation?


Best regards
Luke Walsh
