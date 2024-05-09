Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B4C14883E
	for <linux-serial@vger.kernel.org>; Thu,  9 May 2024 06:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715235914; cv=none; b=OBuwAR99VSfe76+PYi6HWknprvYpttvlEGA/wqycKdMqn0vRPT/ezY11MPFbOahsCv/c9h9q5rqQ8OmErw+F9MfzFLdUadTIEGNnhtqpH+RoL7EfH/NityBDR4/ss6HFbQy00VrxWw5COZ4yE9OIBce8/kR3XEHAFw/MVMjEQy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715235914; c=relaxed/simple;
	bh=VNcxAJhzV4XCG5GoklhPtD4pLaEeiWoa5ws6sH32y9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eP1lwIZOZijApl5d3tQamjUxMU0NemCrZRUFjqbDvP+ICffOottryAtlHx9XZ/0RT4JI/5KdkYfL8b02VSFO0BKhcN6F/CsLqQhJNw6Is3W1pH5BHnZLu+W02PlzjnZVQWQa71NzVoYsRp21PGSDeAf6cKX7sTq6PXTkvDxnSl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=g35u+fgr; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="g35u+fgr"
Received: from cwcc.thunk.org (pool-173-48-113-2.bstnma.fios.verizon.net [173.48.113.2])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 4496Ou82016809
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 9 May 2024 02:24:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1715235898; bh=ghnNBj3hwVBKClwY8+GVmXVmpft6HAMGF8LKN8YstWA=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=g35u+fgrzPJpcdsphmKFB4oyiRmCgoMPMXTwe5SxmGQyuRcBmqr+8evkVSmYGB0SC
	 9agbUpFnxIgr9AGEROLi5aU/vDvRFLuXBIUZxuDKUAZzVTvctSvuNLhqDlCcV7BEd4
	 gRqYPqxzXRK6UHifcjhW9XvXgfBaxa63vfSMNSuimF+noX/Ai3LpG7MiCqWnKxxWS4
	 c3wEEXJnqLVUYUrk5Gaj/u0CmsBVAcMwJMMqW0+VuKhEZR0jqkZY0fX/LdJOqDNHV3
	 wQky6eqgStDqJZjkh2MHa3IhFgkaVAApjRJ6LWZhKmtp6RIRuL28nZ+z+QImK/+t2V
	 wsJ7GAPnKM1XQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 865F015C026D; Thu, 09 May 2024 02:24:56 -0400 (EDT)
Date: Thu, 9 May 2024 02:24:56 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Bagas Sanjaya <bagasdotme@gmail.com>, Rob Herring <robh@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Serial <linux-serial@vger.kernel.org>,
        Elvis <elvisimprsntr@gmail.com>
Subject: Re: Fwd: Add method to allow switching kernel level PPS signal from
 DCD to CTS serial pin
Message-ID: <20240509062456.GE3620298@mit.edu>
References: <Zjra2GZIDC7BPoZx@archie.me>
 <2024050853-basin-salsa-32bb@gregkh>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024050853-basin-salsa-32bb@gregkh>

On Wed, May 08, 2024 at 07:28:35PM +0100, Greg Kroah-Hartman wrote:
> On Wed, May 08, 2024 at 08:52:24AM +0700, Bagas Sanjaya wrote:
> > What do you think about above feature request?
> 
> We will be glad to review any submitted patches for any features.
> patches in bugzilla are not viable for obvious reasons.

Bagas,

Note that the feature request is related to PPS, so per the
MAINTAINERS file entry:

PPS SUPPORT
M:	Rodolfo Giometti <giometti@enneenne.com>
L:	linuxpps@ml.enneenne.com (subscribers-only)
S:	Maintained
W:	http://wiki.enneenne.com/index.php/LinuxPPS_support
F:	Documentation/ABI/testing/sysfs-pps
F:	Documentation/devicetree/bindings/pps/pps-gpio.yaml
F:	Documentation/driver-api/pps.rst
F:	drivers/pps/
F:	include/linux/pps*.h
F:	include/uapi/linux/pps.h

I'd suggest that you reach out to Rondolfo as the maintainer, or to
the linuxpps mailing list.

First of all, looking at the patch referenced in the bugzilla (which
is actually found in github), it appears that the person who made the
request via Bugzilla is different from the the person who authored the
patch (apparently, github.com/not1337).

Secondly, the patch is really quite hacky.  First, the termonology
used of "4wire" is non-standard (e.g., uised nowhere but at
github.com/not1337/pss-stuff), and misleading.  A cable which only has
RxD, TxD, RTS, and CTS is not going to work well without GND, so "4
wire" is quite the misnomer".  This termonology is also not used by
FreeBSD, BTW.  Secondly, unconditionally mapping CTS to DCD when
setting a magic UART-level attribute is a bit hacky, since it will do
this magic ad-hoc mapping all of the time, not only if the PPS line
discpline is selected.

Now, I haven't been the tty maintainer in quite a while, but in my
opinion, a much cleaner way would be to plumb a new tty ldisc
function, cts_change, which is analogous to the dcd_change function
(which was introduced specifically for pps_ldisc).  Then for bonus
points, consider using the pps capture mode mde that FreeeBSD's UART
driver, including the invert option and narrow pulse mode, and eschew
using the non-standard "4wire" naming terminology.

Finally, note that the way kernel development works is that it's not
enough for a user to ask for a feature.  Someone has to create a high
quality, clean, maintainable patch.  Note all random hacks found in
random Bugzilla or Github git trees are suitable for inclusion in the
upstream kernel.  And if you don't know how to evaluate the patch for
quality, it might not be best thing to just ask the bugzilla requester
to follow the Submitting Patches procedure, given that (a) they might
not be a kernel developer, and (b) it might just frustrate the
bugzilla requester and maintainer if the patch isn't sufficient high
quality, especially if you've managed to set expectations that all the
bugzilla requestor needs to do is to submit the patch and it will be
accepted.

Cheers,

					- Ted
