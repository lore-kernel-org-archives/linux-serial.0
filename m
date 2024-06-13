Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D80137758;
	Thu, 13 Jun 2024 19:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718306624; cv=none; b=cqIdzh5xeb0jCmb0U+pCuDpyxJc4gjsGp6YYM1Py4BNxn21vKM1Z31F6Mz+ioBdlG9QfXt95GdysXjS5IDtlShkPfiPHARXa/CAQrW86jghtANsH3eE2eeTXhSUIkIpR0EBZpo3VWn5TSup+Qy4UITxOqACIrKM/0pCf0yzUdGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718306624; c=relaxed/simple;
	bh=BZzEyFhO1RPGl5rXxTzuUYyY7hln3KFS1UAOVUvypys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CwqKSIum50tMX9/mziAYHp8gmXJsr/e8yXHXfFoz7vDEl7SYJcG/gS6x4s/cTzPitI8NQbcrEmeVkey6rrGvMDYiV88zo4m1xrYMkjLGU2IKQobt5B5+e90QUZGMAuSentlwhI3k/oYWOXZOA+gUv8P5VzH+GrHJ1WZaNCJF4OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SFxp9boA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SFxp9boA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 894C6C2BBFC;
	Thu, 13 Jun 2024 19:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718306623;
	bh=BZzEyFhO1RPGl5rXxTzuUYyY7hln3KFS1UAOVUvypys=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SFxp9boA+IUHGfl4c4KFR6r57CpSb7VhflA+O8eGyuJosAS4jWasze6uwc2Zjt2H/
	 farsshJoGslXoX1G81UKfLZaI87iSkpPMwaNxvQYdTpY1aFHIAUXCEwjMFW8sPuAgz
	 McCfpB5hFNLTF1zI3kGnFUkSAf78Q4JXsAf77wDqdQ0bHN5w0mAH3USm2cN9mD6EkB
	 /PsH1/G3FOlpOHDS8G5BDhA8Q+PdtajvbQOOpqeVZl0OJ3h7kKR4RIJZ0EV7ekO+yJ
	 8cFa20e+CvDBKAfx1Xgqmked1k4z7KKO3ByuIpi2WsGiU9f+y7nXFZjbQkTnL3i/oI
	 hCTc4LVlL7p0g==
Date: Thu, 13 Jun 2024 13:23:41 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Kanak Shilledar <kanakshilledar@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jiri Slaby <jirislaby@kernel.org>, kanakshilledar111@protonmail.com,
	Alexey Charkov <alchark@gmail.com>, linux-serial@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3] dt-bindings: serial: vt8500-uart: convert to
 json-schema
Message-ID: <171830661940.2338369.227439942685065275.robh@kernel.org>
References: <20240612153847.52647-2-kanakshilledar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240612153847.52647-2-kanakshilledar@gmail.com>


On Wed, 12 Jun 2024 21:08:43 +0530, Kanak Shilledar wrote:
> Convert the VIA VT8500 and WonderMedia WM8xxx UART Controller to
> newer DT schema. Created DT schema based on the .txt file which had
> `compatible`, `reg`, `interrupts` and `clocks` as required properties.
> 
> Additions to the original binding
> - changed the file name from vt8500-uart to via,vt8500-uart.yaml
> - removed unnecessary alias from the example.
> 
> Signed-off-by: Kanak Shilledar <kanakshilledar@gmail.com>
> ---
> Changes in v3:
> - Removed Rob and myself from maintainers and added Alexey.
> - Fixed commit message which mentioned "greg and jiri as maintainers".
> - Elaborated changelog for v2.
> Changes in v2:
> - Rebased changes
> - Changed maintainers to have Rob and remove Greg and Jiri. VT8500 is
> orphaned according to the maintainers file.
> - Replaced `compatible` property description with comments.
> ---
>  .../bindings/serial/via,vt8500-uart.yaml      | 46 +++++++++++++++++++
>  .../bindings/serial/vt8500-uart.txt           | 27 -----------
>  2 files changed, 46 insertions(+), 27 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/serial/via,vt8500-uart.yaml
>  delete mode 100644 Documentation/devicetree/bindings/serial/vt8500-uart.txt
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

