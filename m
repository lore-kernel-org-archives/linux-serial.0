Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06803C196B;
	Wed, 30 Sep 2026 07:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790751874; cv=none; b=cl+ySMJ5VnelmNqkVkv/gYjStMQ5CVWXWxx+fqNUdzH6YPpkqjX9CL/MOhPiXuo0kHm349dlHQNObSXHLXaeXBOmnr0S2jxwYv/Ca0tLqIWdPUZiiuRvEKA++XPqaS+Jf/PGe3YoqiUufmHFMw47e8w+G+yRohRaX1+rEQMBLNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790751874; c=relaxed/simple;
	bh=NrD24kG/gZ6BhkUsDh8LBCOQX1JQ+yiNK4HWJUqikik=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=S5tNb5hYOStla3VIhkVVaOd9kzDD+HePDGzKVJXFHf4aWWw+MqJ6zyQ6v7zFMMGxKSl8x/+nntdbhBJMlIlz1PC3AV4cjkLPhMZvv7N7MIRxcAnrXfwCmbDpURRggkARDolHzUk5su0jSP8Bv6ATBKjdK1rVANJ7o5Umc2vm1n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HrRFQzg9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HrRFQzg9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B45631F000FF;
	Wed, 30 Sep 2026 07:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790751864;
	bh=NrD24kG/gZ6BhkUsDh8LBCOQX1JQ+yiNK4HWJUqikik=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HrRFQzg9CCg5mrxJkwtsOF4y7D8bxFPwZeNLt7TjG859ECju1pzdwthzqEZ7yTV7H
	 WmU2h1PCBrjrIQlXC2rrt+t9IYwpcmlkWgSCTCaEW0nbKc6SmCrSa4aHgUVhUasnZ5
	 GVbQ2a1/IBnHpJZxK5pU5C1W5YaYAR/ppcXgkxfQQrF6X/hKHeZ+sy88/ZtXdgRzPU
	 30RlSYgY5jg25/VmPy+ZlkNWbW3YRMveMd7y5bzO1O96PeS458nzWg3P5jY3qmGPfm
	 F4q2SrI/6PNNGIUZJVKfoqBg2rhqwCIcOKtlwMaOrChATF+189rbtLPEr3czycoTlc
	 ZqSuGX39WlmeQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 06/10] dt-bindings: serial: Add Cortina Systems
 CS7542 UART
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fil Dunsky" <filipp.dunsky@gmail.com>
Cc: conor+dt@kernel.org, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org
In-Reply-To: <20260930-b4-cs75xx-v1-6-4617c4463529@gmail.com>
References: <20260930-b4-cs75xx-v1-0-4617c4463529@gmail.com>
 <20260930-b4-cs75xx-v1-6-4617c4463529@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 07:04:23 +0000
Message-Id: <20260930070423.B45631F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

> From: Fil Dunsky <filipp.dunsky@gmail.com>
>=20
> Add the binding for the UART found in the Cortina Systems CS75xx
> (Goldengate G2) SoCs such as the CS7542.
>=20
> Signed-off-by: Fil Dunsky <filipp.dunsky@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930-b4-cs75xx-=
v1-0-4617c4463529@gmail.com?part=3D6

