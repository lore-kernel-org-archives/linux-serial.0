Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793115614;
	b=E19KuOSEdrTj/hZBzCjvzlvxP7bXDTyoKUoTDaoIRnuNow4PImwIdrVzz1xcc+9fSiUD
	 oxqZaspzjlmYsDfAGdBLLDdf1WikiavPmN9wx4Ee8+qHRb9dOSUY3CYMsev8/0cTGTwgp
	 DE/niwGmiLoquCj7LRwqaGGdrshKA0PripR5Kfn/jtWO4EBTG3WM8TDhNS3pnPwq8yp+r
	 CrF1i+Px0AAFzdCBafIBFbkDnDDnBy+MOiZtLTZDDQmyLTMH/vL7sL+Mt6i7ygKIxBmTc
	 IHWcCmJQMgLU1Y8ErBkaKgk4PI6G+qaZjtpPhRNImthKkcWKtSpOo+T4RPouDUIJMrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793115614;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=4vCHhbbp3jdRiGTErhK1XH17SWQDhBX+YdDWWVP6Ey8=;
	b=R6zKhP+GK3MFxD9vmlRGyucakc+4lXO1JtX3tqqRnc7B0SC0cGcky9T31BS7La4fBNM8
	 xxsm2P99E9YF4X4bA7a2iOGDssLS9fx/QHqHRydWlbXVkJGX1rPM1R/4YnNUBzrq8aVXg
	 zW/HuA0P1ERtUXAVmjxQzkbiDj2jc2MBlt6hsHqSs40WaGuC7kL8DPZw6hV3VGSaFhhYO
	 mMHIGbeau5bmTWb+sR6pK0hWQKp6YFGYmjCdOc+GbV1M28F09dD16OYJ6LSOxTf4NIl+E
	 fTooLLmRTcrO8zoBfstFW5KG1agGAOiTOO4/A25zr3+iPofthE74fA0EauC1odgGMjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e9WWT597;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6801A606A31B
	for <linux-serial@vger.kernel.org>; Tue, 27 Oct 2026 15:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e9WWT597
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1E1B1F01825;
	Tue, 27 Oct 2026 15:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793115614;
	bh=4vCHhbbp3jdRiGTErhK1XH17SWQDhBX+YdDWWVP6Ey8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=e9WWT597ZN0rhI3uiivSh0XHyTyICsHiUx6JMTDq5ypzoZd8enkVa8U1B/ZNolMYi
	 6bh+2dkyjRKdSzH/JoHtETJWEaknDZts6lDgUw0AbzSA2ZW4eG0wk0ZDP+5HXj8zQw
	 ba0DTbvLyUQHsqqaRlaYHC21fWaF1kP+zB3N8IuOQxoL+3G3LSzb64MZEroCx+i3Zf
	 tOnAV5FR+M7ogXUHCrPTQr52cvaeTL5fcLQne35oSMwiDHNrFBeU6+Pcat1yHtVq1e
	 8174g6DzqgdByGoag4orOsXadWHKn7Wf+zFVm4vlvY0r7/kMT9VQtRZHd6dG7cXXCW
	 N7u0sl9cJ6qVA==
Message-ID: <sashiko-outbox-186854@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 16/18] riscv: dts: zhihe: add Melon Pi V1 and V2
Reply-To: sashiko-reviews@lists.linux.dev
To: "Han Gao" <gaohan@iscas.ac.cn>
Cc: linux-serial@vger.kernel.org
In-Reply-To: <20261027-a210-scmi-v1-16-74d58ce85bd8@iscas.ac.cn>
References: <20261027-a210-scmi-v1-0-74d58ce85bd8@iscas.ac.cn>
 <20261027-a210-scmi-v1-16-74d58ce85bd8@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 15:40:13 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

> From: Han Gao <gaohan@iscas.ac.cn>
>=20
> Add Melon Pi V1 and V2 with the UART4 console on GPIO2_0 and GPIO2_1.
> Use serial aliases to preserve physical UART numbering.
>=20
> Signed-off-by: Han Gao <gaohan@iscas.ac.cn>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027-a210-scmi-=
v1-0-74d58ce85bd8@iscas.ac.cn?part=3D16

