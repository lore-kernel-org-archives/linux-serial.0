Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC7C30E858;
	Wed, 22 Apr 2026 07:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776841855; cv=none; b=cAK2OO7n2yLIwb4tLqg7eG6UV7D5V87c+UQOdp8wwk+1vrrq0Ja1olNt6MDjHLteucTLs8n/gsQYyxoY4MXqL00s+6TjmFhIFzNIeUBwhCRGEILB2B3Aod6+27OrdVXPdrkJ7Zfz3cv8tJNi0pYV17+74t/NXLwIUrdS81G+b3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776841855; c=relaxed/simple;
	bh=MrZFxBlM4jDTKYqBEEmVlzWwDmWAd7KaZsOwy3PL05I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NubdQOEHJjg2RIqQCsaDpCyMSGf2PdWEsFa2BJcD1gBQM/AIASGMiBYEDMdWynH75zBJdZTPzWmSsiB87E9ghteu110ROBBk4kDImgptuSYc8ItF5YX8AG+8txaQkkqsHRjfMq8CS34AxzI9s3agy1Am5ySW+xyuPiU5a+yWOSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UQQ5RD7r; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UQQ5RD7r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35D47C19425;
	Wed, 22 Apr 2026 07:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776841855;
	bh=MrZFxBlM4jDTKYqBEEmVlzWwDmWAd7KaZsOwy3PL05I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UQQ5RD7rkIvYR8OOKyndX9mqAJyFVVurIW0JQ41g4aTfbFLEBRb5ncTG5tXtrVtpU
	 vk1542hR9izrgz2qOJvRx+H5VGDfGMe0R8/zkyA4BtTLuccRPIlysv7JMKET+WBcGE
	 AqARNs4vhK61fnol+c+/290QRIvtX9GiMQJKyjytb6E2vDdMRgQbWgDD58SkEw2TO0
	 Wsrvuu4NLEpOFdrac7Su9LE625xVa1H6d1sExHdU2H9DrYt9H/3VN171xh5xUigpf/
	 4CP//Qmkg/C4UIycgPljLDkpxGWvHG1J73BFvXQMxnS7to11mIrifcufnDjPFczqQL
	 fw10zO26hFi7A==
Date: Wed, 22 Apr 2026 09:10:53 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Stefan =?utf-8?B?RMO2c2luZ2Vy?= <stefandoesinger@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Russell King <linux@armlinux.org.uk>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Linus Walleij <linusw@kernel.org>, 
	Drew Fustini <fustini@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, soc@lists.linux.dev, 
	linux-serial@vger.kernel.org
Subject: Re: [PATCH v5 7/8] ARM: dts: Declare UARTs on zx297520v3 boards
Message-ID: <20260422-vigorous-beautiful-peacock-4ac41b@quoll>
References: <20260421-send-v5-0-ace038e63515@gmail.com>
 <20260421-send-v5-7-ace038e63515@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260421-send-v5-7-ace038e63515@gmail.com>

On Tue, Apr 21, 2026 at 11:23:15PM +0300, Stefan D=C3=B6singer wrote:
> Signed-off-by: Stefan D=C3=B6singer <stefandoesinger@gmail.com>
>=20
> ---
>=20

Same comments about subject and squashing. This cannot be a separate
commit.

Best regards,
Krzysztof

