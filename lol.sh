echo 'Please pick from the following'

select install in gnome xfce plasma none ssh
do
        case $install in 
        gnome|xfce|plasma|none|ssh)   
                break
                ;;
        *)
                echo "Invalid" 
                ;;
        esac
done

#echo "You selected $install" | read -p installvar
