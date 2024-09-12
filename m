Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D68A1A76C3;
	Thu, 12 Sep 2024 13:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726147860; cv=none; b=Apfuxl1xWonf/6PPgwEC9VxPblpny02Z398QdaqnKVszjbyFKOlDh/+uehgzGygJuYAMo0oM39K2UhStwMxN34CvF2FIWeZ/YGgyd48d+Xjdjrsz776+fR1ERatTsdwAkGYbxwwcokFTMRAcgWposWByC13i/k4AzVhC+nvdVnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726147860; c=relaxed/simple;
	bh=46tIaa9hsCnstVfuLQnEiIxT0KlcdoDboC24+BJlMrg=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=r30cZoiLgbyx1iQltvIxlarjV8acGyw7P8WrkzHgr6xvGPzBlnmj/DO755potUWXLw0hFy53I1350R9oAw9R2ktrP2hXwJ8W3Ra5Ws7Us/z4C9XJhhEQggiAz3Ozj7kmC6OYHJQk0LPMO3c6lujZ7YWzpbv85CsL8fNLefWXYpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hmlGyxaM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hmlGyxaM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4DD6C4CEC3;
	Thu, 12 Sep 2024 13:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726147860;
	bh=46tIaa9hsCnstVfuLQnEiIxT0KlcdoDboC24+BJlMrg=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=hmlGyxaMqygq2jWG3/xGcOM9YHNqKUVotatjgmmZeMjK7zFEBWFTk2C8hVlebUOE3
	 jLI7G37ZMiJP9nTdBnYsr0TTES1F9TSnE0QUG0Ppz51EY+02DKF0J9Y+bQMGmSnCRw
	 v6WMCMZOdzfNFTlPA4tulhzL47gM7bRG5eV4B0i/u3rhDULYGxG2Uuu+QNz1w1WPrX
	 uB9TPvDMkk7c7marYEe7CL+J19iZo/84Sqmczh8BrWN+2fYHHJh67qd4UXGwCX7F+3
	 gysCzpu4aSV5ISQ8PHy3/Ay4uf1oq3eBbvswtvXVJYvQlcQVHZ2ers66lF0CPqfq3n
	 VF/d0G5ELqlmw==
Date: Thu, 12 Sep 2024 08:30:59 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Michal Simek <michal.simek@amd.com>
Cc: "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, 
 monstr@monstr.eu, Jiri Slaby <jirislaby@kernel.org>, git@xilinx.com, 
 michal.simek@xilinx.com, Benjamin Gaignard <benjamin.gaignard@st.com>, 
 "open list:TTY LAYER AND SERIAL DRIVERS" <linux-serial@vger.kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-kernel@vger.kernel.org
In-Reply-To: <48055c01f7da7ba4e1592090d3bfedb0ac321bb0.1726142726.git.michal.simek@amd.com>
References: <48055c01f7da7ba4e1592090d3bfedb0ac321bb0.1726142726.git.michal.simek@amd.com>
Message-Id: <172614785898.3201563.3996024318064999067.robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: serial: rs485: Fix rs485-rts-delay
 property


On Thu, 12 Sep 2024 14:05:28 +0200, Michal Simek wrote:
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

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/serial/rs485.yaml: properties:rs485-rts-delay: {'description': 'prop-encoded-array <a b>', '$ref': '/schemas/types.yaml#/definitions/uint32-array', 'maxItems': 2, 'items': [{'description': 'Delay between rts signal and beginning of data sent in milliseconds. It corresponds to the delay before sending data.', 'default': 0, 'maximum': 50}, {'description': 'Delay between end of data sent and rts signal in milliseconds. It corresponds to the delay after sending data and actual release of the line.', 'default': 0, 'maximum': 100}]} should not be valid under {'required': ['maxItems']}
	hint: "maxItems" is not needed with an "items" list
	from schema $id: http://devicetree.org/meta-schemas/items.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/48055c01f7da7ba4e1592090d3bfedb0ac321bb0.1726142726.git.michal.simek@amd.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

