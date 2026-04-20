Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13A7289E17;
	Mon, 20 Apr 2026 08:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776672340; cv=none; b=nb8wjHBCKt459TbSnvzYJtS5KJj101MqeOIHcUful/jKuk27JSwfhl6mGduGOFU0txJcOjfQhugZkijVnZjB66Odmw9rHXS1g2v20j5dzq0Y9R0gXtjb1b4GiBJjbND2J/zmSTRiIgwduLEJBUIJWdWRhjTJ3OyTRVqqRDbgJKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776672340; c=relaxed/simple;
	bh=q8BCjCMSwOjja0kvEOt+iUd5o3JbBJePxK+O6TDUnY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PGKVGI+D9iAoxOeuNISaPPOU3ybH3A1wHmSwOsqTB1JbqgBTNicdZM2DPBJOv5ec58uVA2TqSCNv9wXjy2QXijEvzjp9o/knkS0sbvVLTgVXz1bvWe0bVO8V+ValXuk9t3YPr93vIhcLAz38/URfrRfsKjtz2kPuF4X0ubov82w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RVuueeL7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RVuueeL7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11FAEC19425;
	Mon, 20 Apr 2026 08:05:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776672339;
	bh=q8BCjCMSwOjja0kvEOt+iUd5o3JbBJePxK+O6TDUnY0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RVuueeL7WvovygjGi0vL3m5nF9Q3rtnTJwU3y5CO4YW9i9PwEbafx7iVZIA3XscjM
	 qL0EmMbjvQOmTbLaMvGWB0vHbOo/94bhlpXi9wSVGL2P5v75Vza5MLAoHTg5skJe41
	 fm7jD7inzn/jDlIfCT3W60EyVjq24d1EsQVwWACI=
Date: Mon, 20 Apr 2026 10:05:37 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: =?utf-8?B?6auY57+U?= <gaoxiang17@xiaomi.com>
Cc: Xiang Gao <gxxa03070307@gmail.com>,
	"jirislaby@kernel.org" <jirislaby@kernel.org>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
Subject: Re: =?utf-8?B?562U5aSNOiBbRXh0ZXJuYWwgTWFp?=
 =?utf-8?B?bF1SZTogW1BBVENIXSBzeXNycTogYWQ=?= =?utf-8?Q?d?= optional logging
 of caller info on /proc/sysrq-trigger write
Message-ID: <2026042022-upon-consuming-09ec@gregkh>
References: <20260416131419.1231012-1-gxxa03070307@gmail.com>
 <2026041830-visibly-underpaid-6dc8@gregkh>
 <e973ea4e812b4aef95bce54732c406d7@xiaomi.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e973ea4e812b4aef95bce54732c406d7@xiaomi.com>

On Mon, Apr 20, 2026 at 07:32:45AM +0000, 高翔 wrote:

<snip>

you sent this in html format, which was rejected by the public lists :(
