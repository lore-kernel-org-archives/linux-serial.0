From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 2/2] serdev: ttyport: add missing open() error handling
Date: Tue, 17 Oct 2017 11:08:53 -0500
Message-ID: <CAL_JsqKe_yLODOuUXaivFC3VMoy9EmgUhb+3LRmw5C3DvtdVKg@mail.gmail.com>
References: <20171016130620.5404-1-johan@kernel.org> <20171016130620.5404-2-johan@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171016130620.5404-2-johan@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Johan Hovold <johan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Mon, Oct 16, 2017 at 8:06 AM, Johan Hovold <johan@kernel.org> wrote:
> Add missing error handling for tty-driver open() which may fail (e.g. if
> resource allocation fails or if a port is being disconnected).
>
> Note that close() must be called also in case of failed open() and that
> the operation sanity check is amended to catch buggy drivers.

That's a very odd pattern. Wouldn't a must_check annotation be enough?

Rob
