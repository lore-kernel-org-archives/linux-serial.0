Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E86C316FF4E
	for <linux-serial@vger.kernel.org>; Thu, 29 Feb 2024 21:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709240758; cv=none; b=XBX//EuFfkLCIE/El1xOl/8qvaeY0jml+o1XMQm27A3qVPTuUZ/rBsba+febo34+n2S1NENEC5v+Fzmej3L0W635j3kT+L/B1JSOp9aAo3gj9uDX7Q23Dw7XSVMF0mF89pfJdUamFamvil96G7ld0AkIeUUK/PpuaIFC3fAyu/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709240758; c=relaxed/simple;
	bh=OpSCihavJMSoo0IVlZueg+qMxcLEuhn1BAUcUIpYkF0=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=FasgBWjj5DV1E+/LqrKYNxrlly8Rp68IlgQs9MoGvddDrtL8wSKSeHwcG40ItndLlTEfkcrUgG3DA9x2eQt521kcTpcmJahFYagkz7DDAp74vP3dXewxIRguMkMV+fA/m8ic5/vhI4kPacOLiVnMHMX45C6Oj1DmDJK8pLIDaw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=xYQnC2ff; dkim=pass (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=yaKGdomP; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="xYQnC2ff";
	dkim=pass (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="yaKGdomP"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id C38F61E6C12;
	Thu, 29 Feb 2024 16:05:55 -0500 (EST)
	(envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=date:from
	:to:cc:subject:message-id:mime-version:content-type; s=sasl; bh=
	OpSCihavJMSoo0IVlZueg+qMxcLEuhn1BAUcUIpYkF0=; b=xYQnC2ff7CGj/VPW
	m1mhDiJKlAUNVTXJ8Zn/t++S1M0yzyfsw998qKVKaysbTa+nUpIZRlu9PQ0HsY31
	XUbMLNVg/aMmn7fmfUtCwPU4qOgb4jpIUGiOyCWmMJRFU095ZSsPVd4AK88Ik5Ia
	1VIOrTCcLIl+ZhzHF2CHjysH8zs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id BB78F1E6C11;
	Thu, 29 Feb 2024 16:05:55 -0500 (EST)
	(envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=date:from:to:cc:subject:message-id:mime-version:content-type;
 s=2016-12.pbsmtp; bh=OpSCihavJMSoo0IVlZueg+qMxcLEuhn1BAUcUIpYkF0=;
 b=yaKGdomPJnckuCxJn0HgtktErS9lOz0uqqpfYPtI6M+XZ+l2T25D2lrpfH1Z/fQjZNO1D13a0SWcbeQxmv1khGj65EV8d6aw8BkVyVHKNnuTE+AOlLCZItFamfAAMhiLHLXZFiX50BEFHnuzgRSh4q+mNiYvy3cQT34/U1sFyXQ=
Received: from yoda.fluxnic.net (unknown [24.201.101.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 17A751E6C10;
	Thu, 29 Feb 2024 16:05:53 -0500 (EST)
	(envelope-from nico@fluxnic.net)
Received: from xanadu (unknown [IPv6:fd17:d3d3:663b:0:9696:df8a:e3:af35])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id F0FBBB8779D;
	Thu, 29 Feb 2024 16:05:51 -0500 (EST)
Date: Thu, 29 Feb 2024 16:05:51 -0500 (EST)
From: Nicolas Pitre <nico@fluxnic.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>
cc: linux-serial@vger.kernel.org
Subject: [PATCH] vt: fix unicode buffer corruption when deleting characters
Message-ID: <88n6qo5r-2986-r273-9n4p-pr77q314727r@syhkavp.arg>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Pobox-Relay-ID:
 52C1194C-D746-11EE-8371-25B3960A682E-78420484!pb-smtp2.pobox.com

This is the same issue that was fixed for the VGA text buffer in
commit 39cdb68c64d8 ("vt: fix memory overlapping when deleting chars
in the buffer"). The cure is also the same.

Signed-off-by: Nicolas Pitre <nico@fluxnic.net>
Cc: <stable@kernel.org>
---
diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 156efda7c8..38a765eadb 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -381,7 +381,7 @@ static void vc_uniscr_delete(struct vc_data *vc, unsigned int nr)
 		u32 *ln = vc->vc_uni_lines[vc->state.y];
 		unsigned int x = vc->state.x, cols = vc->vc_cols;
 
-		memcpy(&ln[x], &ln[x + nr], (cols - x - nr) * sizeof(*ln));
+		memmove(&ln[x], &ln[x + nr], (cols - x - nr) * sizeof(*ln));
 		memset32(&ln[cols - nr], ' ', nr);
 	}
 }
-- 
2.44.0

