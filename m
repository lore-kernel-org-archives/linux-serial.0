From: Jiri Slaby <jslaby@suse.cz>
Subject: Re: RFC: drop ISA support in the synlink tty driver?
Date: Tue, 12 Feb 2019 09:40:55 +0100
Message-ID: <14b637cf-44e5-9887-93ca-277976191fd9@suse.cz>
References: <20190211132534.29407-1-hch@lst.de>
 <20190212075151.GA7588@kroah.com>
 <7585c8b6-6dc4-2556-d14f-2fd60dc7df90@suse.cz>
 <20190212082517.GA27889@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190212082517.GA27889@kroah.com>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 12. 02. 19, 9:25, Greg Kroah-Hartman wrote:
> It's just a #define, in a uapi file, so we should probably leave it as
> userspace programs _might_ depend on it.  I have no idea why, but oh
> well...

Uh, I didn't even think this could be in a uapi header. Ok, it makes
sense then.

thanks,
-- 
js
suse labs
