From: Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH] Add sc16is7x2 driver
Date: Tue, 14 Sep 2010 07:27:46 -0600
Message-ID: <20100914072746.4dad4e34@bike.lwn.net>
References: <4C80F419.5070601@iis.fraunhofer.de>
	<20100913172544.a81e8422.akpm@linux-foundation.org>
	<4C8F7381.50300@iis.fraunhofer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4C8F7381.50300@iis.fraunhofer.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Tue, 14 Sep 2010 15:07:13 +0200
Manuel Stahl <manuel.stahl@iis.fraunhofer.de> wrote:

> Where can I find some example how to use the new threaded irqs?

Basic description here: http://lwn.net/Articles/302043/

If you grep request_threaded_irq() in drivers/, you'll certainly find
some real-world examples.

jon
