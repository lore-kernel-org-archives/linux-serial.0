Received: from mx17lb.world4you.com (mx17lb.world4you.com [81.19.149.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1F435676D
	for <linux-serial@vger.kernel.org>; Wed,  3 Jun 2026 12:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.149.127
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780488411; cv=none; b=OZhrsHsHNmtY6l3ej9qGba/VRvGT0GJm5AW5qx0BrGivVLsVHvyO3qSW1Es/kd/rNFO6o89FETBGojhsMUbQbQlswZ+N1Dd4obS2+iwIVn4I8sUZTlswSB866LyzqlT6VWo6f8CauOIizct+6feM7NS/ieiEl0Yuy1+fyjVJFBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780488411; c=relaxed/simple;
	bh=9q183NFC9fS2JbtBL36Ugl1YrAbf8Ci2YCyn/eMtdUU=;
	h=From:To:Subject:Message-ID:Date:MIME-Version:Content-Type; b=LclFrxc38gHGmLrpxEeh8cURPkhrME8Dr6cEznqx69iefUXEdHC0P928k1XG48bzsmyzFVAQHYjA0LN9skCg/LwHiK76X24ggCpEF7Bu+0GOrqy/G+xReKzy3TowfclSj+ouwbzQs/ZiTKl7aAIjkpr2QE70EjkM9/tzzFIsbso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ciaorelated.com; spf=pass smtp.mailfrom=ciaorelated.com; arc=none smtp.client-ip=81.19.149.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ciaorelated.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ciaorelated.com
Received: from 89-26-47-193.stat.cablelink.at ([89.26.47.193] helo=[127.0.0.1])
	by mx17lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <info@ciaorelated.com>)
	id 1wUkGc-000000006bf-1Ui2
	for linux-serial@vger.kernel.org;
	Wed, 03 Jun 2026 14:00:14 +0200
From: Dogan Karaarslan <info@ciaorelated.com>
To: linux-serial@vger.kernel.org
Subject: Open source social media project from Salzburg
Message-ID: <2160df18-b39c-338f-8eef-dab162b7f48f@ciaorelated.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 03 Jun 2026 12:00:13 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-AV-Do-Run: Yes

Hello,

I found your contact through GitHub.

I=E2=80=99m a developer based=
 in Salzburg, and I=E2=80=99ve created an open source social media project =
focused on communities and meaningful connections.

I=E2=80=99d love to share it with you. If you like the idea of an open =
source social media project, I would really appreciate it if you could take=
 a look and maybe star the repository.

I=E2=80=99ve put a lot of heart =
into this project, so any kind of support, feedback, contribution, or =
simply sharing it would mean a lot to me.

Here is the project:
https://github.com/dogankaraarslan1/ciaorelated

Thank you for your time.

Best regards,
Dogan Karaarslan
