From: "Herbert, Marc" <marc.herbert@intel.com>
Subject: Re: [RFC] fs: add userspace critical mounts event support
Date: Fri, 23 Sep 2016 18:37:28 -0700
Message-ID: <2deae6da-dd43-7bff-e1fd-ffd26946b928__16402.1819866777$1474682448$gmane$org@intel.com>
References: <1466117661-22075-3-git-send-email-mcgrof@kernel.org>
 <CAKMK7uGAacZ5Lc1n5CiCVKgKWMS-H3S=8muD-LO+wQjpGnOdJw@mail.gmail.com>
 <20160824203901.GT3296@wotan.suse.de>
 <CAKMK7uEJtEr91SM6V3hZzwMyzTVXJanMtPcWM81RFH_Xyq9KVQ@mail.gmail.com>
 <20160825194133.GC3296@wotan.suse.de> <20160902235916.GO3296@wotan.suse.de>
 <20160903002014.GP3296@wotan.suse.de>
 <CA+55aFy4_QLYiQxtKpq0FJD7eSBRZ8nXS=Ruuz1TYodHdE_dCA@mail.gmail.com>
 <CAKdAkRSQmz3FoP8Z2ONm7-_A9RHF2Ox6snaCpsyS6HA7=+RerQ@mail.gmail.com>
 <CA+55aFz4q5peXAeY9h8o3he7R=wXrBSYkOjMM9TehOw=pPoS+Q@mail.gmail.com>
 <20160903174939.GB32345@dtor-ws>
 <CA+55aFwLrXRUO9n75Sthu+g73BEjskAgUkguyLwU=JA_PNzdOQ@mail.gmail.com>
 <CAKdAkRTv5Fv54wetBqkS+EyEuP_k5exJat+QXBLtTkFLO_-maQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAKdAkRTv5Fv54wetBqkS+EyEuP_k5exJat+QXBLtTkFLO_-maQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-doc@vger.kernel.org, cocci@systeme.lip6.fr, linuxppc-dev@ozlabs.org, linux-serial@vger.kernel.orglinux-doc@vger.kernel.orgcocci@systeme.lip6.frlinux-serial@vger.kernel.orgcocci@systeme.lip6.frlinuxppc-dev@ozlabs.orglinux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 03/09/2016 11:10, Dmitry Torokhov wrote:
> I was thinking if we kernel could post
> "conditions" (maybe simple stings) that it waits for, and userspace
> could unlock these "conditions". One of them might be "firmware
> available".

On idea offered by Josh Triplett that seems to overlap with this one
is to have something similar to the (deprecated) userhelper with
*per-blob* requests and notifications except for one major difference:
userspace would not anymore be in charge of *providing* the blob but
would instead only *signal* when a given blob becomes available and is
either found or found missing. Then the kernel loads the blob _by
itself_; unlike the userhelper. No new “critical filesystem” concept
and a *per-blob basis*, allowing any variation of blob locations
across any number of initramfs and filesystems.

Could this one fly?
