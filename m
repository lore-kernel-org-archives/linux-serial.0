From: Maximilian Luz <luzmaximilian@gmail.com>
Subject: Re: [PATCH] serdev: Add ACPI devices by ResourceSource field
Date: Fri, 20 Sep 2019 22:43:42 +0200
Message-ID: <ff0588a9-d395-3101-ba01-802e736e86a3@gmail.com>
References: <20190919195624.1140941-1-luzmaximilian@gmail.com>
 <50b016a1-ed4a-b848-4658-a05731727d7e@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <50b016a1-ed4a-b848-4658-a05731727d7e@redhat.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Rob Herring <robh@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Johan Hovold <johan@kernel.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-serial@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi,

> So as promised I've given this patch a try, unfortunately it breaks
> existing users of ACPI serdev device instantation.

I've only had a short look at it so far. As far as I can tell, there are
two options: Either the device does not match/is being skipped, or there
are errors (which are currently only reported with dev_dbg, based on the
pre-patch implementation) causing the search to terminate early. I'll
keep investigating this and report back once I've got a better
understanding of the possible sources for this.

> I haven't looked why your patch is breakig things, I have a large backlog
> so I do not have time for that.

No worries, I'll try to figure this out.

> But if you can provide me with a version of the patch with a bunch of
> debug printk-s added I'm happy to run that for you.

Thank you for this offer, I will probably come back to it once I have
more of an idea what could cause the breakage.

Regards,

Maximilian
