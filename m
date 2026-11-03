Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793745066;
	b=JdOWB+p/SDQ7AWh6/em3iRWDhRM4jo+Bwiw/mjJFCIlvu9j1S/VcADCJfLV1JjPAgSlW
	 z3PRtF2AdmkocrgB45i3hmAThCz0STRX2LyQmxce4f9VLAbxIWxnbohhOUlQTrGJsBB0d
	 cWv6XZjn5ekmMUyKfySx2HQliMRsYJLP4McMWq66hlGxcp4Tyxm1tVn43nE3Ys9xIBwD6
	 c7a8qPpr2mSNZGu6f/Uyk+wc6gXujp7oBWuNaeHis4mKoV/zBlPg7SdO7hqilKszC+r+N
	 ykn7EbdUM4Xzc0IVQ7xv/3EF5+O3zQHaKvPcsjEi5fA98uL1qpKpfk1ssqhgN0jH0Fw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793745066;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=PgrNSZ5aXwwCNVzb1MXbnvG2Eqoqlfff0cV0ELzjl1M=;
	b=2NzTJrHmcxVtAKcQT+1mI9pWCrKYePflK8wNIXFRH7tljzCrF2edq9T/uxmGp9zsUG8h
	 lPvIpB2BN0NIyV3YelgjAw4ns7wTxVdkHiJup/aN3X3Lpx0P7xZoRbs2n0IxmwaUfTKa3
	 NDZJhZJ1vj3QDDaxsIQa+R68LxhZuDparaQRZGm3TxFmmbPANtDk6OR2TtXfmJcPo4Ef7
	 /d0JczJ2vXdvBjz5JRUk0UtH+KJAGssvbmtN4YXYuC0kEGaohBgfGf/t1WAC+m1NM2H0T
	 fQ8Py6lHFUdkb4vO0OLZZii/7qRTdnLm+tm8tergijVWX+JkEkufoMJMA73gHb42Tkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Jh+2XZyQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E900D606A33B
	for <linux-serial@vger.kernel.org>; Tue,  3 Nov 2026 22:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Jh+2XZyQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FF181F00A17;
	Tue,  3 Nov 2026 22:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793745065;
	bh=PgrNSZ5aXwwCNVzb1MXbnvG2Eqoqlfff0cV0ELzjl1M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Jh+2XZyQNf3joK/6koVKxmudxyeWYI9j+xsNPnZ4Cg+yMD44qBWKeeTD/82YRtR3B
	 QZgsc+0G+BXmEGmyNnl75zeckuNa1bXXEGmrbJq4IAwfTLudP4anHKFKDsrJ9H+IvW
	 tfEO/uovzXpRrpxTi0RlF8BVQx6zqNdi7+9TVcPIyzQuQCg2H1iydddhyHWNViG1gh
	 ap4IIakTCaUQhFQ28ma4AqNAzHlP+Za8K0ivYrfE3PqqDsy96U6ZTzVT1drOfz/Dec
	 jFQSuF3KKkYVyqxgu9P0nDYcJrRnF+EXj9mwOZDRoFRQAF3OfKIcqvlM6SwweGQt7K
	 Elk4O7FcxCJGQ==
Message-ID: <sashiko-outbox-196116@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 04/10] dmaengine: dw: extract hardware-LLP residue
 calculation
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261103-submit-dw-dma-synchronize-v1-v6-4-2ee0c348224d@gmail.com>
References: <20261103-submit-dw-dma-synchronize-v1-v6-0-2ee0c348224d@gmail.com>
 <20261103-submit-dw-dma-synchronize-v1-v6-4-2ee0c348224d@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 22:31:05 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> From: Serge Semin <fancer.lancer@gmail.com>
>=20
> Move the hardware-LLP residue calculation into
> dwc_get_hard_llp_desc_residue() so it can be reused independently of
> completion handling.
>=20
> Keep the scanner's LLP snapshot, descriptor updates and early returns
> unchanged. The helper reports whether it found the current descriptor,
> including when that descriptor has zero residue, rather than using the
> residue value as a completion indication.
>=20
> Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
> [james: extract the calculation without changing scanner behavior]
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103-submit-dw-=
dma-synchronize-v1-v6-0-2ee0c348224d@gmail.com?part=3D4

