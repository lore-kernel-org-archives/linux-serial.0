Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C03017FACC;
	Wed, 12 Jun 2024 14:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718204100; cv=none; b=W5Ibw8uADGEBQew7EAAz50qN1ra5eiPqgqDUuoGujDkW8FGvwiOMNX85avVaIvdL4lkT4+KRTOXxMViDHX5NcSinw3JTFnWFY6/o3Q5AjOBBlyR0/hEmHJ/CHzC+bCnXFLTI4gNrIUlKqgA5zha2kBO1EaPV2aYaCmzP+zrQzUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718204100; c=relaxed/simple;
	bh=PA6xAANCNywV5yss9NRekbluKzFyiEeXqU8uO1yCpTk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sgezDwiW+sF+TJzgFHfTIKSgQeO3oFVxgjZ3gJ1OCl4GGJHuEXuyjTfDMiXyV1LD1v8H+jBDtUfsILDBAe1i7bMhY2+Fj26sQ5H0ed4oQ/S3LPMN4FMqf9POr+xzpSjlpDlGhqfhW821BVNRlGnMSnYvGBzlJgR5tKYVJ8EAI6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zuUNhh1R; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zuUNhh1R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6306C3277B;
	Wed, 12 Jun 2024 14:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718204100;
	bh=PA6xAANCNywV5yss9NRekbluKzFyiEeXqU8uO1yCpTk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=zuUNhh1RNIrBXIlM0KOAkNvwPQ4q0PQRq2L2i1ZtaddR3igwsoO3lQo+hZ5VsW5iu
	 QJLw6d0kho9MuuCYg8OTaXkzKd/ZFcBg+52/T1/Mfe3S7DXM05rDmC61ZkeJVuk/Tc
	 BwnqH32jwP4Avm8Udpyt5FWFIaW6X6ZlQ2TGFCiY=
Date: Wed, 12 Jun 2024 16:54:57 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Kanak Shilledar <kanakshilledar@gmail.com>
Cc: Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Kanak Shilledar <kanakshilledar111@protonmail.com>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: serial: vt8500-uart: convert to
 json-schema
Message-ID: <2024061237-uncanny-rectify-9e8c@gregkh>
References: <20240612142951.37259-1-kanakshilledar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240612142951.37259-1-kanakshilledar@gmail.com>

On Wed, Jun 12, 2024 at 07:59:45PM +0530, Kanak Shilledar wrote:
> Convert the VIA VT8500 and WonderMedia WM8xxx UART Controller to
> newer DT schema. Created DT schema based on the .txt file which had
> `compatible`, `reg`, `interrupts` and `clocks` as required properties.
> 
> Additions to the original binding
> - changed the file name from vt8500-uart to via,vt8500-uart.yaml
> - removed unnecessary alias from the example.
> - added Greg and Jiri as maintainers (referred MAINTAINERS file).

Really?  Because I see here:

> +maintainers:
> +  - Rob Herring <robh@kernel.org>
> +  - Kanak Shilledar <kanakshilledar111@protonmail.com>

Not me :)

thanks,

greg k-h
