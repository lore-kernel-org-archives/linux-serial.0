Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7631AC45D
	for <linux-serial@vger.kernel.org>; Thu,  4 Jul 2024 11:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720093504; cv=none; b=uuMU8zoLxQvEs2qU5qcPxkUf0Re8VfwmDmPohUetcsHqeZGbZAxTf4tE3/z5HdA9z/2+QE2p0pkO9qhCU+ghJWRWtj6j810DHYx/YPrKoa2mXoYgwkFfandY4t1Szh3UB9WdV39P85AlTsdCG3EIHCxI9iRKSTZoSMRpEia4qoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720093504; c=relaxed/simple;
	bh=syJgtzBT4NnxlMW/QH3WyVHYbCuJ+4asbQq4i1orE3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WfpUvHDQNIjkeG3skfkjCmMG/cf1NVHctHjd7H0BUzrcU22yoA2TNXm9bW/FNwE07bWk8Zyrlhp2DqZ0CabIjCOMnzuhn0VcS0mLqkwYTIjUaJLsJ+FnEx4TYYSdL/VK4itz1LRIZGABHYPE5WpBUIxrSGQmBDHBD3Ci8r7wY+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ZbzeD3O5; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ZbzeD3O5"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2eaa89464a3so5433961fa.3
        for <linux-serial@vger.kernel.org>; Thu, 04 Jul 2024 04:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1720093501; x=1720698301; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Vv7PszY4Q4IaOG1+zreXlUg+dSyiqu4ksayxnh/EYqY=;
        b=ZbzeD3O5wZIMtx5Gl04t26DTSpNUIve5WaMC7tddyLaL6zaKZZmlmJikAOfDMrNNgw
         4yR2KFHaSimLGbkkOm1jCZsNM/D6r6NClkT4Q3bztOb93codyvaswA0KS8sPrleqgt4b
         I9J8iGewfqBoNWAmr19siOaYR6vB3uZUuFpMwU1G31LPPOo7nR1rR4Y0JoUOCJ+uRu0E
         tKU0vcuPzc6ebczH0dL0LZy/QDhIbnu88xFcylMGky9ZjWP8MQygFofGXifam24YtEiu
         v6+Juox3DAfbyh/8wEwp6IzGbL8gcvVVlEo+aPjNAM5etYkJT5Vm9stoQAnIrQu8WK3L
         WoCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720093501; x=1720698301;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vv7PszY4Q4IaOG1+zreXlUg+dSyiqu4ksayxnh/EYqY=;
        b=h9utdQm/AvxcS4cOGHohBdymO9PZA61xWRZnTehA0OjPJstn9M6W1iiwtQSX17pUO0
         A42JSYd7GFZIxBiGtFeuixDUNNGqGOKYyZWou5MaR9Us+blBdPBPophGIirsu99VR+Ix
         zU/mVbGnoM+/RynuYmINjEHlkAo1xwUgCJL/qM/JnrJ8Os3kbeBvRphcNGA9mks1LIYE
         17VfeEUJCfjYhpT3E/lWJdg2xvMXU34wrCYyxik3nmiOEIUXmAvPTIsl45T4uvfd4882
         o8J/JLL9hMhW1X1lG+9Egkzt1jBHkmNbOw9g1BhD90P5ver9uJphw8xEmGIuKfH+kvEZ
         9ELA==
X-Forwarded-Encrypted: i=1; AJvYcCUhfeNvPOhOmr2DF9YmKEgb0noF8u6soWAsN+VqhteXZVx+Pf1TSB40S8sZplY3UXiNcObu0ebFkaY4t9tGZ8KP3lzc9ifXddgWXILq
X-Gm-Message-State: AOJu0YyKCbAe9X+Mrj1JFrtVxiGn812cNK/VJGR1/4v8P5phsCK7USfV
	1U+Rall+Rt9jOoD6uQm9P0HbztgVrdlfdG09vI/LgsmJ2+6teLrEwRHXRM+Iy7Y=
X-Google-Smtp-Source: AGHT+IHdbKZbpmxkTmeDNMfWZoElJCNRAAmEQv55NQl91of41tHtJX2DDGCgU6XdhgxuOrlXLDfp8g==
X-Received: by 2002:a2e:a267:0:b0:2ee:8ce9:3075 with SMTP id 38308e7fff4ca-2ee8ee0fb57mr7323281fa.49.1720093500706;
        Thu, 04 Jul 2024 04:45:00 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac1598d35sm120559865ad.285.2024.07.04.04.44.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 04:45:00 -0700 (PDT)
Date: Thu, 4 Jul 2024 13:44:49 +0200
From: Petr Mladek <pmladek@suse.com>
To: Tony Lindgren <tony.lindgren@linux.intel.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-serial@vger.kernel.org, Tony Lindgren <tony@atomide.com>,
	Dhruva Gole <d-gole@ti.com>, Sebastian Reichel <sre@kernel.org>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] Documentation: kernel-parameters: Add DEVNAME:0.0
 format for serial ports
Message-ID: <ZoaLMQlilpeSlB3S@pathway.suse.cz>
References: <20240703100615.118762-1-tony.lindgren@linux.intel.com>
 <20240703100615.118762-4-tony.lindgren@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240703100615.118762-4-tony.lindgren@linux.intel.com>

On Wed 2024-07-03 13:06:10, Tony Lindgren wrote:
> From: Tony Lindgren <tony@atomide.com>
> 
> Document the console option for DEVNAME:0.0 style addressing for serial
> ports.
> 
> Suggested-by: Sebastian Reichel <sre@kernel.org>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> Reviewed-by: Dhruva Gole <d-gole@ti.com>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
