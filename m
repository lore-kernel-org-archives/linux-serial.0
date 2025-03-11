Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058412571B9
	for <linux-serial@vger.kernel.org>; Tue, 11 Mar 2025 12:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741696817; cv=none; b=OzUW3lbelAbJS2cdssdQV4VSKYi6mawuVp4xoj/T15DbkWxuVe2sXss5N+pw/kLjCkCfgDPBYnT3Nzlu6gnkP8U/FuCPcMSWlfgUTfjTlABHXP5yia68LIxj8zglbYRcEqxlLPhJ45p5HBm73oqWyTE4KnY8/ufmTAiRbhmIHjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741696817; c=relaxed/simple;
	bh=eFLglormP4BRNTD9McBheIkazL8hunpP5eO6YCoRoD0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QLHm4oN5Cko3+sZloKJ81MvdRmnJ4+sT1DUiovoVj2WSP4C4fx+5Z6vAHeZ/HUttoOOCPQ1O8FKp4bqLZZl/QXUijHUL6tXwM1zdUYw0iTv/i9p2Vu471JNk+fqN/kBbHiCP+ivpOvjiaBRsacB8jpYm27vncqYKj7F7BX7X9ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=X0hm4EI7; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="X0hm4EI7"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-390e3b3d3f4so2618364f8f.2
        for <linux-serial@vger.kernel.org>; Tue, 11 Mar 2025 05:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741696813; x=1742301613; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aISzCXBUSpl9Jdl7q1Wak8jR4Cx9Bei2SZjKv/F88EM=;
        b=X0hm4EI7PM4g/EBVtBGHE2kYgtPVj6vYqP0/VUrsQA1FSRTiojMeYsRNxAf61iPZLX
         mLSQS+mJ5FeiqKU0MEIuWNC8Yr8NbT9Qi0OZ5GAr67gbh0ocRTobC+qwZdqbn8EwFJ2D
         x2YAftG3oN68T220lo24HNP9Vc63BBl0jMF4m90ZnlbpOme0N5IX0VShW0MMlhodgCPI
         QMAOarzY8o06cQOtkh3w4EjWSSFigImIr+NiLxAJj7JwHlyuNbfongbuVSKXk/LUwMe4
         TAq2QnNKDFHOSOVNfLayZU6qLDrmECMsZufinD4gpE4hrKO0CSAauyRJNhzTW1ZDNJDG
         fspw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741696813; x=1742301613;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aISzCXBUSpl9Jdl7q1Wak8jR4Cx9Bei2SZjKv/F88EM=;
        b=cwEZEIxAMjR0jFXOPMhI6CDsULox3rdl7SfHqcNh0BPEVVjzTVkrCIqxOhtIPEXr2G
         yjZIHgfVCI0drO3j3ZNL9GlL6LMNvgAejOCf7Z6JZ95yl4pZBFOoZ6QQvbYFTkoyZ0KO
         4Py+OYALxUnC1z4ybLW/8X3ehd0ePXUh5w6OP26Ow09Q8csPcW17JVX8lwyG162e1jDi
         GcHyo6MzMx1QFKx6gASk2j/CIboMF9kjRNyGMXb54rO7INaXrtud5fuXZWWgSn8qf/fy
         /A6twYynpCLFxGZOzTBT1lUtHpUpOw7KFq/7cCYynSpEEzQ42SFeL6FENI2hqgz346xS
         EIxg==
X-Forwarded-Encrypted: i=1; AJvYcCXyNBX+zzUqN3YjiqCC4xASncH+6F/4ZeGJOu3PAnsjijKF0ikTw+Pant0Oh/J9BmOn/Ts0wxrVViEIHjs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJgcOCUU+xR5Pkdzlh0AiGFRSwyEqmxq+YUDaryEdktGRvgqxv
	wpI39pyWlxOKvBuiZdGwiwgZvdyC+6nSOP91NPC81kBcVnP0740kAnp6hQjOoeQ=
X-Gm-Gg: ASbGncvXk2gPpLpfxy3JCM/6vusWZxmKloSmMQkBAzxlqPcxwlv+eV0V1R1YBjbZS8T
	aQAnsHlJUg2O9MJQNWzJ0D/qqcMS7LWg5mcHrvsYYKv9zPDKqGmV56K15GA2A5jasM8ySOjugnR
	Jd1A5Pz+kqy3DcZxtkuaRbZmM4dZ0HPZPnr/cefkU5RdkQtRqN5jIDjshwvGDKZWOe/Z5wtk6Zs
	/GoqQY1uJFAdrjz8YIGRSdqOPOLx9AVyqWREvbQy7fH4CENgqzb54Mbaw/w0ws3vmLd0DaAEIff
	3UXY01LtjDrqfZ8Q/7MirZyd6hfC0FmV6oMsi1LNtgMCQb8=
X-Google-Smtp-Source: AGHT+IH+hqLaIb0ak3/PDp2FI+P/Br6EuYDT0bw+M1n8JTY5wRGCazId9C1SCJxp8KfNPqmCL4R8NQ==
X-Received: by 2002:a05:6000:186b:b0:391:231b:8e0d with SMTP id ffacd0b85a97d-39132dc5632mr17143565f8f.39.1741696813238;
        Tue, 11 Mar 2025 05:40:13 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c1031e3sm17759906f8f.82.2025.03.11.05.40.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 05:40:12 -0700 (PDT)
Date: Tue, 11 Mar 2025 13:40:10 +0100
From: Petr Mladek <pmladek@suse.com>
To: Marcos Paulo de Souza <mpdesouza@suse.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Eric Biederman <ebiederm@xmission.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Todd E Brandt <todd.e.brandt@linux.intel.com>,
	Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org, linux-pm@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH 0/5] printk: renaming some suspend/resume functions and
 one fix for unblanking
Message-ID: <Z9AvKmM4Li57-E2E@pathway.suse.cz>
References: <20250226-printk-renaming-v1-0-0b878577f2e6@suse.com>
 <Z9AShs1dEO0jrgjL@pathway.suse.cz>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9AShs1dEO0jrgjL@pathway.suse.cz>

On Tue 2025-03-11 11:38:00, Petr Mladek wrote:
> On Wed 2025-02-26 16:59:00, Marcos Paulo de Souza wrote:
> > Hello, I've being working on some patches that help to clarify the suspend/resume
> > of printk machinery. The last patch on this patchset address one issue regarding
> > suspended consoles and blanking.
> > 
> > This is a part one patchset that I would like to see merged before I send more patches
> > that will rework the suspend flag (a global suspend flag istead of per console) and
> > the removal of CON_ENABLED flag later on (I've created a function that will forcibly)
> > register the console instead of using this flag.
> > 
> > Please review!
> > 
> > Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> 
> Looks good to me. I could fix the typos when pushing.
> 
> Well, there is one more thing. It seems that the simple graphic logger
> was merged for 6.14-rc1. And the console_stop()/console_start() API
> is used also in drivers/gpu/drm/clients/drm_log.c.
> 
> It is actually the code which motivated this rename, as already
> pointed out by John, see
> https://lore.kernel.org/lkml/ZyoNZfLT6tlVAWjO@pathway.suse.cz/
> 
> Well, I am going to update these two locations when pushing this
> as well. Let's just get this change done.

And I did as mentioned above.

JFYI, the patcheset has been committed into printk/linux.git,
branch for-6.15-console-suspend-api-cleanup.

Best Regards,
Petr
