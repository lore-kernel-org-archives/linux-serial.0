Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEEE61A0BD5;
	Thu, 12 Sep 2024 12:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726143837; cv=none; b=kB5Y82LRmPMJp0aVXyZ5F0PdLdGmFsw63nNUjNRFDuiXIbYnDvXpVL4bP6xI0ijqOhr4Cxb+RC/KDW5nvSloTJ2oqa5zUzmdZptQ4X8W+eIaWR4WbxmhWXHZvqELCDdLHb15/K+0sYyXr2WPQjmNBpIh2BKAr2n45sSz/CeYc4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726143837; c=relaxed/simple;
	bh=FHxQBD811f4wuLLHxZal6ftv+scVHwgbQgfWsa9Uh3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AdEM4k1GpdrrOz/MWJO1HQF4jtlRDNI6EM6EzSSl464yvPv6oNuUoCBkOW9sfl4EX562gfWuCygd4fZW1IP1g1221ab0H+IoPtdkMejJqMx5oBDFVb/ibdGbw9ersBL4DbbJv7hrT7N10hb3QKCuKtv1UCyBdcKMnHrttcnfN1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qBSMHIsN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qBSMHIsN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18F0DC4CEC3;
	Thu, 12 Sep 2024 12:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1726143836;
	bh=FHxQBD811f4wuLLHxZal6ftv+scVHwgbQgfWsa9Uh3I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qBSMHIsNWgtrP/lOaZnpjAibIPdgnswN02fFTdpO9tC43sFlzirivyLaNVwzlGJJc
	 7AqarIJJBioy4sofv1RMuByfq1nWUasa0/Ogm3blazu9VCwQOKkUF0u3aBe7aE4B02
	 kS60jW5tnAobYIvhCcK4rVidERRjWaD9covT2cmc=
Date: Thu, 12 Sep 2024 14:23:53 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Michal Simek <michal.simek@amd.com>
Cc: linux-kernel@vger.kernel.org, monstr@monstr.eu, michal.simek@xilinx.com,
	git@xilinx.com, Benjamin Gaignard <benjamin.gaignard@st.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	"open list:TTY LAYER AND SERIAL DRIVERS" <linux-serial@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: serial: rs485: Fix rs485-rts-delay property
Message-ID: <2024091245-glorified-exodus-b1e4@gregkh>
References: <48055c01f7da7ba4e1592090d3bfedb0ac321bb0.1726142726.git.michal.simek@amd.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48055c01f7da7ba4e1592090d3bfedb0ac321bb0.1726142726.git.michal.simek@amd.com>

On Thu, Sep 12, 2024 at 02:05:28PM +0200, Michal Simek wrote:
> Code expects array only with 2 items which should be checked.
> But also item checking is not working as it should likely because of
> incorrect items description.
> 
> Fixes: d50f974c4f7f ("dt-bindings: serial: Convert rs485 bindings to json-schema")
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>  .../devicetree/bindings/serial/rs485.yaml     | 20 +++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/serial/rs485.yaml b/Documentation/devicetree/bindings/serial/rs485.yaml
> index 9418fd66a8e9..fa9ad68ed24b 100644
> --- a/Documentation/devicetree/bindings/serial/rs485.yaml
> +++ b/Documentation/devicetree/bindings/serial/rs485.yaml
> @@ -17,17 +17,17 @@ properties:
>    rs485-rts-delay:
>      description: prop-encoded-array <a b>
>      $ref: /schemas/types.yaml#/definitions/uint32-array
> +    maxItems: 2
>      items:
> -      items:
> -        - description: Delay between rts signal and beginning of data sent in
> -            milliseconds. It corresponds to the delay before sending data.
> -          default: 0
> -          maximum: 100
> -        - description: Delay between end of data sent and rts signal in milliseconds.
> -            It corresponds to the delay after sending data and actual release
> -            of the line.
> -          default: 0
> -          maximum: 100
> +      - description: Delay between rts signal and beginning of data sent in
> +          milliseconds. It corresponds to the delay before sending data.
> +        default: 0
> +        maximum: 50
> +      - description: Delay between end of data sent and rts signal in milliseconds.
> +          It corresponds to the delay after sending data and actual release
> +          of the line.
> +        default: 0
> +        maximum: 100
>  
>    rs485-rts-active-high:
>      description: drive RTS high when sending (this is the default).
> -- 
> 2.43.0
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- You have marked a patch with a "Fixes:" tag for a commit that is in an
  older released kernel, yet you do not have a cc: stable line in the
  signed-off-by area at all, which means that the patch will not be
  applied to any older kernel releases.  To properly fix this, please
  follow the documented rules in the
  Documentation/process/stable-kernel-rules.rst file for how to resolve
  this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
